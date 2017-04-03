<template>
  <div class="fighter-vue">

    <button class="btn btn-danger p-1 remove-button"
      aria-label="Remove"
      v-on:click="removeFighter()">
      <i class="fa fa-times"></i>
    </button>

    <div class="row mb-4">

      <div class="col col-5">
        <h4>
          {{ fighter.name }} -
          <em>{{ fighter.cost }} points</em>
        </h4>
        <label for="chooseNewWeapon">Add weapons / equipment:</label>
        <select class="form-control" name="chooseNewWeapon"
          v-on:change="chooseNewWeapon"
          v-model="newWeapon">
          <option v-for="weapon, key in weaponsAvailable"
            :value="weapon"
          >{{ weapon.name }}</option>
        </select>
      </div>

      <div class="col col-6">
        <fighter-stats :statstring="fighter.stats">
        </fighter-stats>
      </div>

    </div>

    <fighter-wargear
      :fighterIndex="index"
      :wargear="fighter.wargear"
      :weapons="fighter.weapons"
    ></fighter-wargear>

  </div>
</template>

<script lang="coffee">

  import FighterStats from './Stats.vue'
  import FighterWargear from './Wargear.vue'

  Fighter =

    components: { FighterStats, FighterWargear }

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

  export default Fighter

</script>

<style lang="sass">
  .remove-button
    position: absolute
    right: 0.25em
    top: 0.25em
</style>
