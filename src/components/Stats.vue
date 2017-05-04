<template>
  <div class="stats-vue">
    <table class="table table-sm table-bordered">
      <tr>
        <th class="p-1 text-center"
          v-for="label in statLabels"
          >{{ label }}</th>
      </tr>
      <tr>
        <td class="p-1 text-center"
          v-for="stat, index in stats">
          <span class="changed" v-if="statChanged(stat, index)">{{ stat }}</span>
          <span v-else>{{ stat }}</span>
        </td>
      </tr>
    </table>
  </div>
</template>

<script lang="coffee">

  import StatData from '../data/stats.toml'

  Stats =

    props: ['statstring', 'statmasks']

    computed:
      originalStats: () -> @statstring.split ' '
      statLabels: () -> StatData.labels

      stats: () ->
        if @statmasks.length < 1
          @originalStats
        else
          _.reduce @statmasks, @mergeStats, @originalStats

    methods:

      statChanged: (stat, index) ->
        stat != @originalStats[index]

      mergeStats: (stats, mask) ->
        _.chain stats
          .zip mask.split ' '
          .map (x) ->
            if (x[1] || 0) > 0
              parseInt(x[0], 10) + parseInt(x[1], 10)
            else x[0]
          .value()

  export default Stats

</script>
