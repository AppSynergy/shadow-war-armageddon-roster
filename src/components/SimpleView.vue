<template>
  <div class="simple-view-vue container">

    <static-nav
      :factionId="factionId"
      :numberFighters="totalNumberFighters"
      :pointsCost="totalPointsCost"
      :dirty="dirty" :empty="empty">
    </static-nav>

    <div class="my-5 hidden-print text-center">
      <button data-clipboard-target="#clipboard-target"
        class="btn btn-primary" id="clipboard-button">
        <i class="material-icons align-middle pb-1">content_copy</i>
        <span>Copy to clipboard</span>
      </button>
    </div>

    <div class="card p-5 my-4" id="clipboard-target">
      <h3 class="my-4">{{ teamName }} &mdash; {{ factionName }} &mdash; {{ totalPointsCost}} points</h3>
      <span v-for="fighter in chosenFighters">
        <strong>{{ fighter.name }}</strong> &mdash; {{ toTextList(fighter.weapons) }}
      </span><br>
    </div>

  </div>
</template>

<script lang="coffee">

  import Clipboard from 'clipboard'
  import FactionData from '../data/factions.toml'
  import StaticNav from './StaticNav.vue'
  import TeamSummary from './mixin/TeamSummary.coffee'

  new Clipboard '#clipboard-button'

  SimpleView =

    props: ['factionId']

    components: { StaticNav }

    mixins: [ TeamSummary ]

    computed:
      teamName: () -> @$store.getters.getTeamName
      factionName: () -> FactionData[@factionId].name
      chosenFighters: () -> @$store.getters.getFighters

    methods:

      toTextList: (array) ->
        names = _.map array, (x) -> x.name + ' (' + x.cost + ')'
        names.join ', '

  export default SimpleView

</script>
