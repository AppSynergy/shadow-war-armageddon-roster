<template>
  <div class="stats-vue">
    <table class="table table-sm table-bordered">
      <tr>
        <th class="p-1 text-center"
          v-for="label in statLabels"
          >{{ label }}</th>
      </tr>
      <tr>
        <td class="p-1 text-center stat-td"
          v-for="stat, index in displayStats">
          <i class="change-stat material-icons up"
            v-on:click="clickIncrease(index)">keyboard_arrow_up</i>
          <span class="changed" v-if="statChanged(stat, index)">{{ stat }}</span>
          <span v-else>{{ stat }}</span>
          <i class="change-stat material-icons down"
            v-on:click="clickDecrease(index)">keyboard_arrow_down</i>
        </td>
      </tr>
    </table>
  </div>
</template>

<script lang="coffee">

  import StatData from '../data/stats.toml'

  Stats =

    props:
      index:
        default: 0
        type: Number
      statstring:
        default: ''
        type: String
      statmasks:
        default: []
        type: Array
      campaignStatmask:
        default: ''
        type: String
      editable:
        default: false
        type: Boolean

    computed:
      statLabels: () -> StatData.labels
      originalStats: () -> @statstring.split ' '
      displayStats: () ->
        stats = @mergeStats @originalStats, @campaignStatmask
        if @statmasks.length < 1
          return stats
        else
          _.reduce @statmasks, @mergeStats, stats

    methods:

      clickIncrease: (index) ->
        @$store.commit 'increaseCampaignStat',
          index: @index
          statIndex: index

      clickDecrease: (index) ->
        @$store.commit 'decreaseCampaignStat',
          index: @index
          statIndex: index

      statChanged: (stat, index) ->
        stat != @originalStats[index]

      mergeStats: (stats, mask) ->
        _.chain stats
          .zip mask.split ' '
          .map (x) => @sumValues x
          .value()

      sumValues: (x) ->
        if (x[1] || 0) > 0
          (parseInt(x[0], 10) + parseInt(x[1], 10)).toString()
        else x[0]

  export default Stats

</script>

<style lang="sass">
  .stat-td
    position: relative
    &:hover > .change-stat
      visibility: visible
      opacity: 1
  .change-stat
    position: absolute
    left: 0
    visibility: hidden
    opacity: 0
    cursor: pointer
    transition: visibility 0s, opacity 0.5s linear
    &.up
      top: -0.9em
      background-color: cyan !important
    &.down
      top: 1.2em
      background-color: magenta !important
</style>
