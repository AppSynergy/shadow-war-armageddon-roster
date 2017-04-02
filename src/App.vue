<template>
  <div id="app">
    <div class="container">

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
        <h2>Roster</h2>
        <div v-for="fighter, index in chosenFighters">
          {{ fighter.name }}
          {{ fighter.stats }}
          <button v-on:click="removeFighter(index)">Remove</button>
        </div>
      </div>

    </div>
  </div>
</template>

<script lang="coffee">

  import Faction from './data/skitarii.toml'

  App =
    name: 'app',

    computed:
      factionName: () -> Faction.name
      availableFighters: () -> Faction.fighters

    data: () ->
      chosenFighters: []

    methods:
      addFighter: (fighter) ->
        @chosenFighters.push fighter
      removeFighter: (index) ->
        @chosenFighters.splice index, 1

  export default App

</script>

<style lang="scss">
  @import '../node_modules/bootstrap/scss/bootstrap.scss';
</style>
