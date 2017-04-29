<template>
  <div class="simple-view-vue container">

    <div class="my-5 hidden-print text-center">
      <router-link :to="'/build/'+factionId"
        class="btn btn-primary" role="button">
        Return to list builder
      </router-link>
    </div>

    <div class="card p-5 my-4">
      <h3 class="my-4">{{ teamName }} &mdash; {{ factionName }} &mdash; {{ totalPointsCost}} points</h3>
      <span v-for="fighter in chosenFighters">
        <strong>{{ fighter.name }}</strong> &mdash; {{ toTextList(fighter.weapons) }}
      </span>
    </div>

  </div>
</template>

<script lang="coffee">

  import FactionData from '../data/factions.toml'

  SimpleView =

    props: ['factionId']

    computed:
      teamName: () -> @$store.getters.getTeamName
      factionName: () -> FactionData[@factionId].name
      chosenFighters: () -> @$store.getters.getFighters
      totalPointsCost: () -> @$store.getters.getTotalPointsCost

    methods:

      toTextList: (array) ->
        names = _.map array, (x) -> x.name + ' (' + x.cost + ')'
        names.join ', '

  export default SimpleView

</script>
