<template>
  <div class="roster-vue">

    <div class="card px-4 mt-4">
      <h2 class="my-4">{{ faction.name }}</h2>
      <ul class="list-group mb-4">
        <li v-for="fighter in faction.fighters"
          class="list-group-item justify-content-between">
          <span>{{ fighter.name }} -
            <em>{{ fighter.cost }} points</em>
          </span>
          <button class="btn btn-primary"
            v-on:click="addFighter(fighter)">Add</button>
        </li>
      </ul>
    </div>

    <div class="card px-4 mt-4">
      <h2 class="my-4">Roster
        - <em>{{ totalPointsCost }} points</em></h2>
      <div class="card mb-4 p-2"
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

    computed:
      faction: () -> Faction
      chosenFighters: () -> @$store.getters.getFighters
      totalPointsCost: () -> @$store.getters.getTotalPointsCost

    methods:

      addFighter: (fighter) ->
        @$store.commit 'addFighter', _.clone(fighter)

      weaponsAvailable: (fighter) ->
        _.filter Faction.weapons, (_, group) ->
          fighter.equip.includes group
        .reduce ((xs,x) -> _.extend xs, x ), {}

  export default Roster

</script>
