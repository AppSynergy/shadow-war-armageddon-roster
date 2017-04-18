<template>
  <div id="app">
    <div class="container">
      <h1 class="site-name text-center text-uppercase mt-4 mb-0">
        Shadow War: Argameddon Rosters
      </h1>
      <router-view></router-view>
    </div>
  </div>
</template>

<script lang="coffee">

  import Home from './vues/Home.vue'
  import Roster from './vues/Roster.vue'

  App =
    name: 'app'
    components: { Roster }
    created: () ->
      @$router.addRoutes [
        { path: '/', component: Home, name: 'home' }
        { path: '/build/:factionId', component: Roster, props: true }
      ]

  export default App

</script>

<style lang="sass">


  $color1: rgba(132, 140, 142, 1)
  $color2: rgba(67, 80, 88, 1)
  $color3: rgba(220, 247, 99, 1)
  $color4: rgba(191, 183, 182, 1)
  $color5: rgba(241, 242, 238, 1)
  $color6: rgba(224, 82, 99, 1)

  $brand-info: $color2
  $brand-primary: $color1
  $brand-success: $color1
  $brand-danger: $color6

  @import '../node_modules/bootstrap/scss/bootstrap.scss'
  @import url('https://fonts.googleapis.com/css?family=Montserrat|Open+Sans')
  html body
    margin-bottom: 10em
    &, select
      font-family: 'Montserrat'
    background-color: $color5
    h1.site-name
      font-size: 120%
    h4
      font-size: 110%
    button
      cursor: pointer

  .fighter-background
    background-color: $color5

  .team-background
    background-color: lighten($color5, 3)

  .stats-vue
    table
      border: 2px solid $color2
    td, th
      width: 10%
      background-color: white

  //.faction-card
    height: 6em

  //.saved-roster-card, .faction-card
    border: 2px solid $color2

</style>
