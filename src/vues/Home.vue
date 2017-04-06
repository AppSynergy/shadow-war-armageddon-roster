<template>
  <div class="home-vue">
    <h2 class="my-4 text-center">Choose a faction:</h2>
    <ul class="nav nav-fill">
      <li class="nav-item" v-for="faction, factionId in factions">
        <router-link class="nav-link" :to="'/build/'+factionId"
        ><h3>{{ faction.name }}</h3></router-link>
      </li>
    </ul>
  </div>
</template>

<script lang="coffee">

  import Factions from '../data/factions.toml'

  Home =
    computed:
      factions: () -> Factions

  export default Home

</script>
