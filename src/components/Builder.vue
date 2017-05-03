<template>
  <div class="roster-vue mb-4 container">

    <div class="card px-4 mt-4 team-background">
      <div class="card-header px-0 team-background">
        <span class="float-right">
          <router-link class="btn btn-primary action-btn" to="/" role="button">
            <i class="material-icons align-middle pb-1">home</i> <span>Home</span>
          </router-link>
          <button class="btn btn-primary action-btn" :disabled="!dirty"
            v-on:click="saveRoster()">
            <i class="material-icons align-middle pb-1">file_download</i> <span>Save</span>
          </button>
          <router-link class="btn btn-primary action-btn"
            :disabled="empty" role="button" tag="button"
            :to="'/roster-view/'+factionId">
            <i class="material-icons align-middle pb-1">print</i> <span>Roster View</span>
          </router-link>
            <router-link class="btn btn-primary action-btn"
              :disabled="empty" role="button" tag="button"
              :to="'/simple-view/'+factionId">
              <i class="material-icons align-middle pb-1">assignment</i> <span>Simple View</span>
            </router-link>
        </span>
      </div>

      <h2 class="my-4 text-center">{{ faction.name }}</h2>
      <div class="fighter-row row mb-4">
        <div class="col col-12 col-sm-6"
          v-for="fighter in faction.fighters" v-if="faction">
          <div class="card available-fighter-card mb-2 bg-inverse text-white">

            <div class="my-0">
              <button class="btn btn-success align-top ml-1 mt-1"
              :disabled="cannotAddFighter(fighter)"
                v-on:click="addFighter(fighter)">Add</button>
              <span class="d-inline-block mt-1">
                <div class="pl-2">{{ fighter.name }}</div>
                <div class="pl-2 up-a-bit"><small>{{ fighter.role }}</small></div>
              </span>
              <span class="float-right mt-1 mr-4">{{ fighter.cost }} points</span>
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

    <div class="card px-4 mt-4 team-background" v-if="totalNumberFighters > 0">
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

      <draggable v-model="chosenFighters">
        <fighter v-for="fighter, index in chosenFighters"
          :index="index"
          :key="'fighter' + index"
          :weaponsAvailable="weaponsAvailable(fighter)"
          v-on:duplicateFighter="duplicateFighter"
        ></fighter>
      </draggable>

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
  import Draggable from 'vuedraggable'
  import Fighter from './Fighter.vue'
  import Modal from './Modal.vue'
  import Storage from './mixin/Storage.coffee'

  Roster =

    props: ['factionId']

    components: { Draggable, Fighter, Modal }

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
          errors.push { desc: 'You can\'t have more than ' + @faction.size.max + ' fighters in this kill team.' }
        if @teamName == ''
          errors.push { desc: 'Your kill team needs a name.'}
        if @$store.getters.getNumberFightersByRole('Kill Team Leader') != 1
          errors.push { desc: 'Your kill team needs a leader.'}
        if @$store.getters.getNumberFightersByRole('New Recruit') > @totalNumberFighters/2
          errors.push { desc: 'Your kill team has too many new recruits.' }
        errors

      chosenFighters:
        get: () -> @$store.getters.getFighters
        set: (value) -> @$store.commit 'updateFighters', value

      dirty: () -> @$store.getters.getDirty
      totalPointsCost: () -> @$store.getters.getTotalPointsCost
      totalNumberFighters: () -> @$store.getters.getTotalNumberFighters
      empty: () -> @totalNumberFighters == 0

    mounted: () ->
      @event 'open_roster', @factionId
      @track 'build/' + @factionId
      @teamName = @$store.getters.getTeamName

    beforeRouteLeave: (to, from, next) ->
      nextEvent = () =>
        @event 'exit_roster', to.path
        next()
      if to.path.match /\/[a-z]+-view\/[a-z_]+$/
        nextEvent()
      else
        if @totalNumberFighters == 0 || @dirty is false
          @$store.commit 'discardRoster'
          nextEvent()
        else
          @discardAction = nextEvent
          jQuery('#' + @modalId).modal 'show'
          @event 'exit_roster_warn', to.path
    methods:

      processModalOption: (option) ->
        if option.name == 'save' then @saveRoster()
        jQuery('#' + @modalId).modal 'hide'
        @$store.commit 'discardRoster'
        @discardAction()

      saveRoster: () ->
        @event 'save_roster', @factionId
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
        @event 'name_team', @teamName
        @$store.commit 'nameTeam', @teamName

      addFighter: (fighter) ->
        @event 'add_fighter', fighter.name
        @$store.commit 'addFighter',
          fighter: _.clone(fighter)
          wargear: @faction.wargear

      duplicateFighter: (fighter) ->
        unless @cannotAddFighter fighter
          @event 'duplicate_fighter', fighter.name
          @$store.commit 'duplicateFighter', fighter

      cannotAddFighter: (fighter) ->
        roleCount = @$store.getters.getNumberFightersByRole(fighter.role)
        switch fighter.role
          when "Kill Team Leader" then roleCount >= @faction.size.leader_max
          when "Specialist" then roleCount >= @faction.size.specialist_max
          when "Drone" then roleCount >= @faction.size.drone_max
          else false

      weaponsAvailable: (fighter) ->
        _.chain @faction.weapons
          .tap @mapRoles
          # include weapons from groups the fighter can use
          .filter  (weapons, group) -> _.includes fighter.equip, group
          # collect into one list
          .reduce ((xs, x) -> _.extend xs, x ), {}
          .tap @mapKeys
          .reject (weapon, key) =>
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

            # reject stuff where you can only have one, period
            not_weapon_global = if _.has weapon, 'not_weapon_global'
              allWeapons = _.map @chosenFighters, (x) -> x.weapons
              allWeaponKeys = _.map _.flatten(allWeapons), (x) -> x.key
              not _.isEmpty _.intersection(weapon.not_weapon_global, allWeaponKeys)
            else false

            _.any [only_fighter, only_weapon, not_weapon, not_weapon_global]
          .value()

  export default Roster

</script>
