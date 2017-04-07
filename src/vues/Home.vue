<template>
  <div class="home-vue">

    <h2 class="my-4 py-4 text-center">Create a New Roster</h2>

    <div class="roster-new">
      <p class="text-center">Choose your faction!</p>
      <div class="row">
        <div class="col col-6 col-md-4 col-lg-3"
          v-for="faction, factionId in factions">
          <router-link :to="'/build/'+factionId">
            <div class="card faction-card mb-3 p-3 text-center">
            <h3>{{ faction.name }}</h3>
            </div>
          </router-link>
        </div>
      </div>
    </div>

    <div class="roster-load" v-if="hasSavedRosters">
      <h2 class="my-4 py-4 text-center">or Load a Saved Roster</h2>
      <ul class="nav nav-fill">
        <li class="nav-item" v-for="roster in savedRosters">
          <button class="btn btn-primary"
            v-on:click="loadRoster(roster)">Load</button>
          {{ roster.teamName }} {{ roster.factionId }}
          <div v-for="fighter in roster.fighters">{{ fighter.name }}</div>
        </li>
      </ul>
    </div>

  </div>
</template>

<script lang="coffee">

  import Factions from '../data/factions.toml'

  Home =

    computed:
      factions: () -> Factions
      savedRosters: () -> @$localStorage.get 'rosters'
      hasSavedRosters: () -> @savedRosters.length > 0

    localStorage:
      rosters:
        type: Array
        default: []

    methods:
      loadRoster: (roster) ->
        @$router.push('/build/' + roster.factionId)
        @$store.commit 'loadRoster', roster

  export default Home

</script>
