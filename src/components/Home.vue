<template>
  <div class="home-vue">

    <h2 class="my-4 py-4 text-center">Create a New Roster</h2>

    <div class="roster-new">
      <p class="text-center">Choose your faction!</p>
      <div class="row">
        <div class="col col-12 col-md-4 col-lg-3"
          v-for="faction, factionId in factions">
          <router-link v-if="faction.implemented"
            :to="'/build/'+factionId" class="text-white">
            <div class="card faction-card mb-3 p-3 text-center"
              :style="{backgroundColor: faction.color}">
              <h5 class="text-faction-color m-0 text-white">{{ faction.name }}</h5>
            </div>
          </router-link>
          <div v-else class="card mb-3 p-3 text-center">
            <h5 class="text-faction-color m-0">{{ faction.name }}</h5>
            <span>coming soon</span>
          </div>
        </div>
      </div>
    </div>

    <div class="roster-load" v-if="hasSavedRosters">
      <h2 class="my-4 py-4 text-center">or Load a Saved Roster</h2>
      <div class="row">
        <div class="col col-12 col-md-6 col-lg-4"
          v-for="roster in savedRosters">
          <div class="card mb-3 saved-roster-card">
            <div class="card-header">
              <h4 v-if="roster.teamName != ''" class="m-0">{{ roster.teamName }}</h4>
              <h4 v-else class="m-0">Unnamed {{ factions[roster.factionId].name }} Team</h4>
            </div>
            <div class="card-block">
              <p>{{ factions[roster.factionId].name }},
                {{ roster.fighters.length }} fighters,
                {{ roster.totalPointsCost }} points</p>
              <div class="btn-group">
                <button class="btn btn-primary"
                  v-on:click="loadRoster(roster)">Load</button>
                <button class="btn btn-danger"
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

  import Disqus from './mixin/Disqus.coffee'
  import Factions from '../data/factions.toml'
  import Modal from './Modal.vue'
  import Storage from './mixin/Storage.coffee'

  Home =

    components: { Modal }

    mixins: [ Disqus, Storage ]

    data: () ->
      modalId: 'deleteRosterModal'
      modalOptions: [
        {name: 'no', text: 'No thanks'}
        {name: 'yes', text: 'Yes please'}
      ]
      rosterToDelete: null
      savedRosters: []

    computed:
      factions: () -> Factions
      hasSavedRosters: () -> @savedRosters.length > 0

    created: () ->
      @savedRosters = @$localStorage.get 'rosters'

    beforeRouteEnter: (to, from, next) ->
      next((vm) => vm.disqusReset())

    methods:

      loadRoster: (roster) ->
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
        @savedRosters = @deleteRosterLocal @rosterToDelete

  export default Home

</script>
