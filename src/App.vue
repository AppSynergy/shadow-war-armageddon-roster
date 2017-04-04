<template>
  <div id="app">
    <div class="container">
      <h1 class="site-name text-center mt-4 mb-0">
        Shadow War: Argameddon Rosters
      </h1>
      <roster></roster>
    </div>
  </div>
</template>

<script lang="coffee">

  import Roster from './vues/Roster.vue'

  App =
    name: 'app'
    components: { Roster }

  export default App

</script>

<style lang="sass">
  @import '../node_modules/bootstrap/scss/bootstrap.scss'
  @import url('https://fonts.googleapis.com/css?family=Montserrat|Open+Sans')
  html body
    &, select
      font-family: 'Montserrat'
    h1.site-name
      font-size: 140%
      text-transform: uppercase

  html body
    background-color: #E4F4F2

  .roster-background

  .fighter-background
    background-color: #DAECEB
    color: #444

  .wargear-vue .card

  .stats-vue
    td, th
      width: 10%
      background-color: white
      border-color: #DAECEB !important

</style>
