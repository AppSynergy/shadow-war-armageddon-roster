<template>
  <div id="app">

    <div v-for="fighter in availableFighters">
      {{ fighter.name }}
      <button v-on:click="addFighter(fighter)">Add</button>
    </div>

    <h2>Roster</h2>
    <div v-for="fighter, index in chosenFighters">
      {{ fighter.name }}
      {{ fighter.stats }}
      <button v-on:click="removeFighter(index)">Remove</button>
    </div>

  </div>



</template>

<script lang="coffee">

  import Skitarii from './data/skitarii.toml'

  App =
    name: 'app',

    computed:
      availableFighters: () -> Skitarii.fighters

    data: () ->
      chosenFighters: []

    methods:
      addFighter: (fighter) ->
        @chosenFighters.push fighter
      removeFighter: (index) ->
        @chosenFighters.splice index, 1

  export default App

</script>
