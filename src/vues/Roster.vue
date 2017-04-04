<template>
  <div class="roster-vue">

    <div class="card px-4 mt-4 roster-background">
      <h2 class="my-4">{{ faction.name }}</h2>
      <ul class="nav mb-4">
        <li v-for="fighter in faction.fighters"
          class="nav-item justify-content-between">
          <span>{{ fighter.name }} -
            <em class="badge badge-info">{{ fighter.cost }} points</em>
          </span>
          <button class="btn btn-success"
            v-on:click="addFighter(fighter)">Add</button>
        </li>
      </ul>
    </div>

    <div class="card px-4 mt-4 roster-background">
      <div class="row">
        <div class="col col-12 col-md-6">
          <input class="form-control my-4" type="text" v-model="teamName"
            v-on:change="nameTeam"
            placeholder="Name your kill-team">
        </div>
        <div class="col col-12 col-md-6">
          <h2 class="my-4">{{ totalPointsCost }} points / 0 promethium</h2>
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
  import Faction from '../data/skitarii.toml'

  Roster =

    components: { Fighter }

    data: () ->
      teamName: ""

    computed:
      faction: () ->
        Faction.fighters = @mapKeys Faction.fighters
        Faction
      chosenFighters: () -> @$store.getters.getFighters
      totalPointsCost: () -> @$store.getters.getTotalPointsCost

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
          wargear: Faction.wargear

      weaponsAvailable: (fighter) ->

        # include weapons from groups the fighter can use
        weaponList = _.filter Faction.weapons, (weapons, group) ->
            fighter.equip.includes group
        # collect into one list
        .reduce ((xs,x) -> _.extend xs, x ), {}

        # add keys
        weaponList = _.map weaponList, (x, key) ->
          x.key = key
          x

        _.reject weaponList, (weapon, key) ->

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


  export default Roster

</script>
