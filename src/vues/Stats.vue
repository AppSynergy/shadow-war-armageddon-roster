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

    props: ['statstring']

    computed:
      stats: () ->
        @statstring.split ' '
      statLabels: () ->
        StatData.labels

  export default Stats

</script>
