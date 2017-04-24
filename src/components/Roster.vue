<template>
  <div class="roster-vue mb-4">

    <div class="card px-4 mt-4 team-background">
      <div class="card-header team-background">
        <span class="float-right">
          <router-link class="btn btn-primary" to="/" role="button">Home</router-link>
          <button class="btn" :disabled="!dirty"
            v-on:click="saveRoster()">Save</button>
        </span>
      </div>

      <h2 class="my-4 text-center">{{ faction.name }}</h2>
      <div class="fighter-row row mb-4">
        <div class="col col-6 col-md-3"
          v-for="fighter in faction.fighters" v-if="faction">
          <div class="card available-fighter-card">
            <div class="card-block text-center py-2">
              <h4 class="my-0">{{ fighter.name }}</h4>
              <div class="mt-1 mb-2">
                <em class="badge badge-info">{{ fighter.cost }} points</em>
              </div>
              <button class="btn btn-success"
              :disabled="cannotAddFighter(fighter)"
                v-on:click="addFighter(fighter)">Add</button>
            </div>
          </div>
        </div>
      </div>
    </div>

    <div class="notifications mt-4">
      <transition-group name="fade">
        <div v-for="note in notifications" v-bind:key="note.id"
          class="alert alert-success">
          {{ note.desc }}
        </div>
      </transition-group>
    </div>

    <div class="errors mt-4">
      <div v-for="error in errors" class="alert alert-danger">
        {{ error.desc }}
      </div>
    </div>

    <div class="card px-4 mt-4 team-background">
      <div class="row">
        <div class="col col-12 col-lg-6">
          <input class="form-control my-4" type="text" v-model="teamName"
            v-on:change="nameTeam"
            placeholder="Name your kill-team">
        </div>
        <div class="col col-12 col-lg-6">
          <h3 class="pt-1 my-4" v-if="faction">
            {{ totalPointsCost }} points
            <span class="float-right">
              {{ totalNumberFighters }} / {{ faction.size.min}} - {{ faction.size.max }} models
            </span>
          </h3>
        </div>
      </div>
      <div class="chosen-fighter-card card mb-4 px-2 py-4 fighter-background"
        v-for="fighter, index in chosenFighters">
        <fighter
          :index="index"
          :weaponsAvailable="weaponsAvailable(fighter)"
        ></fighter>
      </div>
    </div>

    <modal
      :title="'Unsaved Roster'"
      :body="'You have an unsaved roster, would you like to save it?'"
      :id="modalId"
      :options="modalOptions"
      v-on:selectedOption="processModalOption"
    ></modal>

  </div>
</template>

<script lang="coffee">

  import Analytics from './mixin/Analytics.coffee'
  import Collections from './mixin/Collections.coffee'
  import Fighter from './Fighter.vue'
  import Modal from './Modal.vue'
  import Storage from './mixin/Storage.coffee'

  Roster =

    props: ['factionId']

    components: { Fighter, Modal }

    mixins: [ Analytics, Collections, Storage ]

    data: () ->
      teamName: ""
      modalId: "unsavedRosterModal"
      modalOptions: [
        {name: 'discard', text: 'No thanks'}
        {name: 'save', text: 'Yes please'}
      ]
      chosenFaction: null
      discardAction: () -> null
      notifications: []

    computed:

      faction: () ->
        try
          Faction = require '../data/factions/' + @factionId + '.toml'
          Faction.fighters = @mapKeys Faction.fighters
          Faction
        catch error
          false

      errors: () ->
        errors = []
        if @totalNumberFighters < @faction.size.min
          errors.push { desc: 'You need at least ' + @faction.size.min + ' fighters in this kill team.' }
        if @totalNumberFighters > @faction.size.max
          errors.push { desc: 'You can\'t have more than ' + @faction.size.min + ' fighters in this kill team.' }
        if @teamName == ''
          errors.push { desc: 'Your kill team needs a name.'}
        if @$store.getters.getNumberFightersByRole('Kill Team Leader') != 1
          errors.push { desc: 'Your kill team needs a leader.'}
        errors

      dirty: () -> @$store.getters.getDirty
      chosenFighters: () -> @$store.getters.getFighters
      totalPointsCost: () -> @$store.getters.getTotalPointsCost
      totalNumberFighters: () -> @$store.getters.getTotalNumberFighters

    mounted: () ->
      @track 'build/' + @factionId
      @teamName = @$store.getters.getTeamName

    beforeRouteLeave: (to, from, next) ->
      if @totalNumberFighters == 0 || @dirty is false
        @$store.commit 'discardRoster'
        next()
      else
        @discardAction = next
        jQuery('#' + @modalId).modal 'show'

    methods:

      processModalOption: (option) ->
        if option.name == 'save' then @saveRoster()
        jQuery('#' + @modalId).modal 'hide'
        @$store.commit 'discardRoster'
        @discardAction()

      saveRoster: () ->
        @$store.commit 'cleanState'
        @saveRosterLocal
          fighters: @chosenFighters
          factionId: @factionId
          teamName: @teamName
        @notifications.push { id: 'save', desc: 'Roster saved.' }
        window.setTimeout (() => @clearNotification()), 2000

      clearNotification: () ->
        @notifications = _.reject @notifications, (x) -> x.id == 'save'

      nameTeam: () ->
        @$store.commit 'nameTeam', @teamName

      addFighter: (fighter) ->
        @$store.commit 'addFighter',
          fighter: _.clone(fighter)
          wargear: @faction.wargear

      cannotAddFighter: (fighter) ->
        roleCount = @$store.getters.getNumberFightersByRole(fighter.role)
        switch fighter.role
          when "Kill Team Leader" then roleCount >= @faction.size.leader_max
          when "Specialist" then roleCount >= @faction.size.specialist_max
          else false

      weaponsAvailable: (fighter) ->
        _.chain @faction.weapons
          .tap @mapRoles
          # include weapons from groups the fighter can use
          .filter  (weapons, group) -> _.includes fighter.equip, group
          # collect into one list
          .reduce ((xs, x) -> _.extend xs, x ), {}
          .tap @mapKeys
          .reject (weapon, key) ->

            # reject stuff that can only be used by a different team member
            only_fighter = if _.has weapon, 'only_fighter'
              not _.contains weapon.only_fighter, fighter.key
            else false

            # reject stuff where you need another item first
            only_weapon = if _.has weapon, 'only_weapon'
              _.isEmpty _.intersection(weapon.only_weapon.values,
                _.pluck(fighter.weapons, weapon.only_weapon.matches))
            else false

            # reject stuff where another item prohibits it
            not_weapon = if _.has weapon, 'not_weapon'
              not _.isEmpty _.intersection(weapon.not_weapon, _.pluck(fighter.weapons, 'key'))
            else false

            _.any [only_fighter, only_weapon, not_weapon]
          .value()

  export default Roster

</script>
