<template>
  <div id="app">
    <div class="container">
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

<style lang="scss">
  @import '../node_modules/bootstrap/scss/bootstrap.scss';
</style>
