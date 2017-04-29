<template>
  <div class="roster-view-vue m-2">

    <div class="my-5 hidden-print text-center">
      <router-link :to="'/build/'+factionId"
        class="btn btn-primary" role="button">
        Return to list builder
      </router-link>
    </div>

    <div class="roster-view">

      <div class="my-3 px-3 roster-view-header row">
        <div class="col col-12 col-md-5">
          <h4>Faction: {{ factionName }}</h4>
        </div>
        <div class="col col-12 col-md-5">
          <h4> Kill Team Name: {{ teamName }}</h4>
        </div>
        <div class="col col-12 col-md-2">
          <h4>{{ totalPointsCost }} points</h4>
        </div>
      </div>

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
    font-size: 90%
    font-family: "Courier New", serif
    border: 2px solid #444
    background-color: white
  .roster-view-header h4
    font-weight: 700
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

  import FactionData from '../data/factions.toml'
  import StatData from '../data/stats.toml'

  RosterView =

    props: ['factionId']

    data: () ->
      labels: ['Name', 'Role', 'Characteristics', 'Equipment, Skills and Notes', 'Mission Completed', 'Miss Next Mission']

    computed:
      factionName: () -> FactionData[@factionId].name
      statLabels: () -> StatData.labels
      chosenFighters: () -> @$store.getters.getFighters
      teamName: () -> @$store.getters.getTeamName
      totalPointsCost: () -> @$store.getters.getTotalPointsCost

    methods:
      getStats: (fighter) -> fighter.stats.split ' '

  export default RosterView

</script>
