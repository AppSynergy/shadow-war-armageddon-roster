<template>
  <div id="app">
    <div class="container hidden-print">
      <h1 class="site-name text-center text-uppercase mt-4 mb-0">
        Shadow War: Argameddon Kill Teams &middot; killteams.com
      </h1>
    </div>
    <router-view></router-view>
    <div v-if="$route.name == 'home'" class="container mt-5">
       <disqus shortname="killteams-com" identifier="/"
        url="https://killteams.com/"></disqus>
    </div>
    <a class="hidden-print hidden-md-down"
      href="https://github.com/AppSynergy/shadow-war-armageddon-roster">
      <img style="position: absolute; top: 0; left: 0; border: 0;"
        :src="bannerSrc" :data-canonical-src="bannerSrcCanonical"
        alt="Fork me on GitHub">
    </a>
  </div>
</template>

<script lang="coffee">

  import Home from './components/Home.vue'
  import Builder from './components/Builder.vue'
  import Disqus from 'vue-disqus/VueDisqus.vue'
  import RosterView from './components/RosterView.vue'
  import SimpleView from './components/SimpleView.vue'

  App =

    name: 'app'

    components: { Disqus }

    data: () ->
      bannerSrc: 'https://camo.githubusercontent.com/121cd7cbdc3e4855075ea8b558508b91ac463ac2/68747470733a2f2f73332e616d617a6f6e6177732e636f6d2f6769746875622f726962626f6e732f666f726b6d655f6c6566745f677265656e5f3030373230302e706e67'
      bannerSrcCanonical: 'https://s3.amazonaws.com/github/ribbons/forkme_left_green_007200.png'

    created: () ->
      @$router.addRoutes [
        { path: '/', component: Home, name: 'home' }
        { path: '/build/:factionId', component: Builder, props: true }
        { path: '/roster-view/:factionId', component: RosterView, props: true }
        { path: '/simple-view/:factionId', component: SimpleView, props: true }
      ]

  export default App

</script>

<style lang="sass">

  @media print
    .no-print-container
      width: 100%
      position: absolute
      left: 0
      top: 0
    @page
      margin: 0
      //size: landscape

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
  @import url('https://fonts.googleapis.com/css?family=Montserrat|Open+Sans|Material+Icons')

  html body
    &, select
      font-family: 'Montserrat'
    background-color: $color5
    h1.site-name
      font-size: 120%
    h2
      font-size: 135%
    h4
      font-size: 110%
    button
      cursor: pointer

  h2.faction-name
    @include media-breakpoint-down(sm)
      font-size: 120%

  .team-background
    background-color: lighten($color5, 3)

  .stats-vue
    td, th
      width: 10%
      background-color: white
    span.changed
      color: $brand-danger

  .fade-enter-active, .fade-leave-active
    transition: opacity 0.6s
  .fade-enter, .fade-leave-to
    opacity: 0

  .roster-meta
    height: 38px
    line-height: 38px
    margin: 0
    @include media-breakpoint-up(md)
      text-align: left

  .errors .alert
    @include media-breakpoint-down(sm)
      font-size: 80%
      margin: 0.5em 0 0.5em

  .chosen-fighter-card
    cursor: move
    .card-header
      @include media-breakpoint-down(sm)
        padding: 0.5em

  .up-a-bit
    line-height: 60%

  .action-btn
    border: none
    background-color: transparent
    &.disabled
      cursor: disabled
    i
      line-height: 16px



</style>
