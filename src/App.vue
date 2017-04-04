<template>
  <div id="app">
    <div class="container">
      <h1 class="site-name text-center text-uppercase mt-4 mb-0">
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
    background-color: #E4F4F2
    h1.site-name
      font-size: 120%
    h4
      font-size: 110%

  .stats-vue
    td, th
      width: 10%
      background-color: white

</style>
