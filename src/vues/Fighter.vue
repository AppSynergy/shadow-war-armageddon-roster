<template>
  <div class="fighter-vue">
    <div class="row">

      <div class="col col-4">

        <h4>
          {{ fighter.name }} -
          <em>{{ fighter.cost }} points</em>
        </h4>

        <label for="chooseNewWeapon">Add weapons / equipment:</label>
        <select class="" name="chooseNewWeapon"
          v-on:change="chooseNewWeapon"
          v-model="newWeapon">
          <option v-for="weapon, key in weaponsAvailable"
            :value="weapon"
          >{{ weapon.name }}</option>
        </select>

        <ul class="list-group">
          <li class="list-group-item justify-content-between"
            v-for="weapon, index in fighter.weapons">
            <span title="weapon.desc">
              {{ weapon.name }}
            </span>
            <em>{{ weapon.cost }} points</em>
            <button class="btn btn-danger p-1"
              v-on:click="removeWeapon(index)">Remove</button>
          </li>
        </ul>

      </div>

      <div class="col col-6">
        <fighter-stats :statstring="fighter.stats">
        </fighter-stats>
      </div>

      <div class="col col-2">
        <button class="btn btn-danger"
          v-on:click="removeFighter()">Remove</button>
      </div>

    </div>
  </div>
</template>

<script lang="coffee">

  import FighterStats from './Stats.vue'

  Fighter =

    components: { FighterStats }

    props: ['index', 'weaponsAvailable']

    data: () ->
      newWeapon: null
      weapons: []

    computed:
      fighter: () -> @$store.getters.getFighter @index

    methods:

      chooseNewWeapon: () ->
        @$store.commit "addWeapon",
         weapon: @newWeapon
         index: @index

      removeFighter: () ->
        @$store.commit 'removeFighter', @index

      removeWeapon: (index) ->
        @$store.commit 'removeWeapon',
          weaponIndex: index
          index: @index

  export default Fighter

</script>
