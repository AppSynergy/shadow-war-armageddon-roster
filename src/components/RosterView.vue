<template>
  <div class="roster-view-vue">

    <div class="my-5">
      <router-link :to="'/build/'+factionId"
        class="btn btn-primary" role="button">
        Return to list builder
      </router-link>
    </div>

    <div class="roster-view">

      <h3 class="my-3 roster-view-header">
        <span class="mr-5">
          Faction: <span class="text-uppercase">{{ factionName }}</span>
        </span>
        <span class="mr-5">
          Kill Team Name: <span class="text-uppercase">{{ teamName }}</span>
        </span>
      </h3>

      <table class="table">
        <thead class="thead-inverse">
          <tr>
            <th class="text-uppercase align-middle"
              v-for="label in labels">{{ label }}</th>
          </tr>
        </thead>
        <tbody>
          <tr v-for="fighter in chosenFighters">
            <td>
              <strong v-if="fighter.realName">{{ fighter.realName }}</strong>
              <strong v-else>An unnamed soldier</strong>
              <br>{{ fighter.name }}
            </td>
            <td>{{ fighter.role }}</td>
            <td><table class="table table-sm table-bordered">
              <thead class="thead-inverse">
                <tr>
                  <th class="p-1 text-center stat-header"
                    v-for="label in statLabels"
                    >{{ label }}</th>
                </tr>
              </thead>
              <tbody>
                <tr>
                  <td class="p-1 text-center"
                    v-for="stat in getStats(fighter)"
                    >{{ stat }}</td>
                </tr>
              </tbody>
            </table></td>
            <td>
              <div class="items">
                <span class="item" v-for="item in fighter.wargear">{{ item.name }} </span>
                <span class="item" v-for="item in fighter.weapons">{{ item.name }} </span>
              </div>
            </td>
            <td>
              <div class="a_rectangle"></div>
              <div class="a_rectangle"></div>
              <div class="a_rectangle"></div>
            </td>
            <td>
              <div class="a_rectangle"></div>
            </td>
          </tr>
        </tbody>
      </table>

    </div>

  </div>
</template>

<style lang="sass">
  .roster-view
    border: 2px solid #444
    background-color: white
  .roster-view-header
    padding: 0 2em
  .item
    margin-right: 1em
    display: block
    white-space: nowrap
  .a_rectangle
    width: 1.5em
    height: 1.5em
    border: 2px solid #444
    display: inline-block
</style>

<script lang="coffee">

  import StatData from '../data/stats.toml'

  RosterView =

    props: ['factionId']

    data: () ->
      labels: ['Name', 'Role', 'Characteristics', 'Equipment, Skills and Notes', 'Mission Completed', 'Miss Next Mission']

    computed:
      factionName: () -> @factionId.replace '_', ' '
      statLabels: () -> StatData.labels
      chosenFighters: () -> @$store.getters.getFighters
      teamName: () -> @$store.getters.getTeamName

    methods:
      getStats: (fighter) -> fighter.stats.split ' '

  export default RosterView

</script>
