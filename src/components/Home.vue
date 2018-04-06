<template>
  <div class="home-vue container">

    <nav class="navigation-vue navbar navbar-expand-sm navbar-inverse fixed-top bg-dark">
      <a href="#" class="navbar-brand text-white">killteams.com</a>
      <span class="navbar-text text-white ml-4 pt-2 d-none d-md-inline">
        Shadow War: Armageddon Kill Teams
      </span>
      <span class="ml-auto d-none d-md-inline">
        <a target="_blank" class="text-white" :href="ghUrl">killteams.com on GitHub</a>
      </span>
    </nav>

    <h2 class="my-4 py-4 text-center">Create a New Roster</h2>

    <div class="roster-new">
      <div class="text-center mb-3">Choose your faction!
        <div class="form-check d-inline-block pl-5" v-for="game, gameId in games">
          <input class="form-check-input" type="checkbox" :value="gameId"
            v-model="gamesSelected" :id="'showGame_'+gameId">
          <label class="form-check-label" :for="'showGame_'+gameId">{{ game }}</label>
        </div>
      </div>
      <template v-for="gameFactions, gameId in visibleFactions">
        <h2 class="text-center my-4 py-2">{{ games[gameId] }}</h2>
        <div class="row">
          <div class="col col-12 col-sm-6 col-md-4 col-lg-3"
            v-for="faction, factionId in gameFactions">
            <router-link v-if="faction.implemented"
              :to="'/build/'+factionId" class="text-white">
              <div class="card faction-card mb-3 p-3 text-center"
                :style="{backgroundColor: faction.color}" >
                <h5 class="text-faction-color m-0 text-white">{{ faction.name }}</h5>
              </div>
            </router-link>
            <div v-else class="card mb-3 p-3 text-center">
              <h5 class="text-faction-color m-0">{{ faction.name }}</h5>
              <span>coming soon</span>
            </div>
          </div>
        </div>
      </template>
    </div>

    <div class="roster-load" v-if="hasSavedRosters">
      <h2 class="my-4 py-4 text-center">or Load a Saved Roster</h2>
      <div class="row">
        <div class="col col-12 col-md-6 col-lg-4"
          v-for="roster in savedRosters">
          <div class="card mb-3 saved-roster-card">
            <div class="card-header text-white" :style="{backgroundColor: getColor(roster)}">
              <h4 v-if="roster.teamName != ''" class="m-0">{{ roster.teamName }}</h4>
              <h4 v-else class="m-0">Unnamed {{ factions[roster.factionId].name }} Team</h4>
            </div>
            <div class="card-body">
              <p>{{ factions[roster.factionId].name }},
                {{ roster.fighters.length }} fighters,
                {{ roster.totalPointsCost }} points</p>
              <div class="btn-group">
                <button class="btn btn-secondary"
                  v-on:click="loadRoster(roster)">Load</button>
                <button class="btn btn-dark"
                  v-on:click="deleteRoster(roster)">Delete</button>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>

    <modal
      :title="'Delete Roster'"
      :body="'Are you sure you want to delete this roster?'"
      :id="modalId"
      :options="modalOptions"
      v-on:selectedOption="processModalOption"
    ></modal>

  </div>
</template>

<script lang="coffee">

  import Analytics from './mixin/Analytics.coffee'
  import Factions from '../data/factions.toml'
  import Modal from './Modal.vue'
  import Storage from './mixin/Storage.coffee'

  Home =

    components: { Modal }

    mixins: [ Analytics, Storage ]

    data: () ->
      games:
        necromunda: 'Necromunda',
        shadowWar: 'Shadow War: Armageddon'
      gamesSelected: ['necromunda', 'shadowWar']
      modalId: 'deleteRosterModal'
      modalOptions: [
        {name: 'no', text: 'No thanks'}
        {name: 'yes', text: 'Yes please'}
      ]
      rosterToDelete: null
      savedRosters: []
      ghUrl: 'https://github.com/AppSynergy/shadow-war-armageddon-roster'

    computed:
      factions: () -> Factions
      hasSavedRosters: () -> @savedRosters.length > 0

      visibleFactions: () ->
        groups = _.object(@gamesSelected, @gamesSelected)
        _.mapObject groups, (game) =>
          _.pick @factions, (x) => game == x.game

    created: () ->
      @savedRosters = @$localStorage.get 'rosters'

    beforeRouteEnter: (to, from, next) ->
      next (vm) =>
        vm.track '/'

    methods:

      getColor: (roster) ->
        @factions[roster.factionId].color

      loadRoster: (roster) ->
        @event 'load_roster', roster.factionId
        @$router.push('/build/' + roster.factionId)
        @$store.commit 'loadRoster', roster

      deleteRoster: (roster) ->
        @rosterToDelete = roster
        jQuery('#' + @modalId).modal 'show'

      processModalOption: (option) ->
        if option.name is 'yes' then @reallyDeleteRoster()
        @rosterToDelete = null
        jQuery('#' + @modalId).modal 'hide'

      reallyDeleteRoster: () ->
        @event 'delete_roster', @rosterToDelete.teamName
        @savedRosters = @deleteRosterLocal @rosterToDelete

  export default Home

</script>
