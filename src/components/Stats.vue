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
          v-for="stat in stats"
          >{{ stat }}</td>
      </tr>
    </table>
  </div>
</template>

<script lang="coffee">

  import StatData from '../data/stats.toml'

  Stats =

    props: ['statstring', 'statchanges']

    computed:
      stats: () ->
        stats = @statstring.split ' '
        if @statchanges.length > 0
          _.map @statchanges, (x) =>
            index = _.indexOf @statLabels, x.stat
            stats[index] = parseInt(stats[index], 10) + parseInt(x.change, 10)
        stats

      statLabels: () ->
        StatData.labels

  export default Stats

</script>
