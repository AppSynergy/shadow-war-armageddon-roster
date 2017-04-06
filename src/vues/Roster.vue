<template>
  <div class="roster-vue mb-4">

    <div class="card px-4 mt-4 bg-faded">
      <h2 class="my-4 text-center">{{ faction.name }}</h2>
      <ul class="nav mb-4 justify-content-between">
        <li v-for="fighter in faction.fighters" v-if="faction"
          class="nav-item">
          <h4>{{ fighter.name }}</h4>
          <em class="badge badge-info">{{ fighter.cost }} points</em>
          <button class="btn btn-success"
          :disabled="cannotAddFighter(fighter)"
            v-on:click="addFighter(fighter)">Add</button>
        </li>
      </ul>
    </div>

    <div class="card px-4 mt-4 bg-faded">
      <div class="row">
        <div class="col col-12 col-md-6">
          <input class="form-control my-4" type="text" v-model="teamName"
            v-on:change="nameTeam"
            placeholder="Name your kill-team">
        </div>
        <div class="col col-12 col-md-6">
          <h2 class="my-4" v-if="faction">
            {{ totalPointsCost }} points
            <span class="float-right">
              {{ totalNumberFighters }} / {{ faction.size.max }} models
            </span>
          </h2>
        </div>
      </div>
      <div class="card mb-4 px-2 py-4 fighter-background"
        v-for="fighter, index in chosenFighters">
        <fighter
          :index="index"
          :weaponsAvailable="weaponsAvailable(fighter)"
        ></fighter>
      </div>
    </div>

  </div>
</template>

<script lang="coffee">

  import Fighter from './Fighter.vue'

  Roster =

    props: ['factionId']

    components: { Fighter }

    data: () ->
      chosenFaction: null
      teamName: ""

    computed:
      faction: () ->
        try
          Faction = require '../data/' + @factionId + '.toml'
          Faction.fighters = @mapKeys Faction.fighters
          Faction
        catch error
          false

      chosenFighters: () -> @$store.getters.getFighters
      totalPointsCost: () -> @$store.getters.getTotalPointsCost
      totalNumberFighters: () -> @$store.getters.getTotalNumberFighters

    methods:

      mapKeys: (collection) ->
        _.map collection, (x, key) ->
          x.key = key
          x

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
          # include weapons from groups the fighter can use
          .filter  (weapons, group) -> fighter.equip.includes group
          # collect into one list
          .reduce ((xs, x) -> _.extend xs, x ), {}
          .tap @mapKeys
          .reject (weapon, key) ->
            # reject stuff that can only be used by a different team member
            only_fighter = _.every [
              _.has weapon, 'only_fighter'
              not _.contains weapon.only_fighter, fighter.key
            ]
            # reject stuff where you need another item first
            only_weapon = _.every [
              _.has weapon, 'only_weapon'
              _.isEmpty _.intersection(weapon.only_weapon, _.pluck(fighter.weapons, 'key'))
            ]
            _.any [only_fighter, only_weapon]
          .value()

  export default Roster

</script>
