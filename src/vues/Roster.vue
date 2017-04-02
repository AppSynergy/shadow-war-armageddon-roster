<template>
  <div class="roster-vue">

    <div class="card my-4 p-2">
      <h2>{{ factionName }}</h2>
      <ul class="list-group">
        <li v-for="fighter in availableFighters"
          class="list-group-item justify-content-between">
          <span>{{ fighter.name }} -
            <em>{{ fighter.cost }} points</em>
          </span>
          <button v-on:click="addFighter(fighter)">Add</button>
        </li>
      </ul>
    </div>

    <div class="card p-2">
      <h2>Roster - <em>{{ totalPointsCost }} points</em></h2>
      <div v-for="fighter, index in chosenFighters">
        <fighter
          :fighter="fighter"
          :index="index"
          v-on:removeFighterIndex="removeFighter"
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
      factionName: () -> Faction.name
      availableFighters: () -> Faction.fighters
      totalPointsCost: () ->
        @chosenFighters.reduce ((acc,x) -> acc + x.cost), 0

    data: () ->
      chosenFighters: []

    methods:
      addFighter: (fighter) ->
        @chosenFighters.push fighter
      removeFighter: (index) ->
        @chosenFighters.splice index, 1

  export default Roster

</script>
