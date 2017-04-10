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
      <div class="row">
        <div class="col col-12 col-md-6 col-lg-4"
          v-for="roster in savedRosters">
          <div class="card mb-3">
            <div class="card-header">
              <h4 class="m-0">{{ roster.teamName }}</h4>
            </div>
            <div class="card-block">
              <p>{{ factions[roster.factionId].name }},
                {{ roster.fighters.length }} fighters</p>
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

  import Factions from '../data/factions.toml'
  import Modal from './Modal.vue'
  import Storage from './Storage.coffee'

  Home =

    components: { Modal }

    mixins: [ Storage ]

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
