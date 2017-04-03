<template>
  <div class="fighter-vue">
    <div class="row">
      <div class="col col-2">
        {{ fighter.name }}
      </div>
      <div class="col col-2">
        <em>{{ fighter.cost }} points</em>
      </div>
      <div class="col col-6">
        <fighter-stats :statstring="fighter.stats">
        </fighter-stats>
      </div>
      <div class="col col-2">
        <button class="btn btn-danger"
          v-on:click="removeFighter(index)">Remove</button>
      </div>
    </div>
  </div>
</template>

<script lang="coffee">

  import FighterStats from './Stats.vue'

  Fighter =

    components: { FighterStats }

    props: ['fighter', 'index']

    methods:
      removeFighter: (index) ->
        @$emit 'removeFighterIndex', index

  export default Fighter

</script>
