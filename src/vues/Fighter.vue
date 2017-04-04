<template>
  <div class="fighter-vue">

    <button class="btn btn-danger p-1 remove-button"
      aria-label="Remove"
      v-on:click="removeFighter()">
      <i class="fa fa-times"></i>
    </button>

    <div class="row">
      <div class="col col-12 col-md-6 col-lg-3">
        <h4>{{ fighter.name }}</h4>
        <div>{{ fighter.role}}</div>
        <input class="form-control mr-2" type="text"
          placeholder="Name me!"
          v-on:change="nameFighter"
          v-model="fighter.realName">
      </div>

      <div class="col col-12 col-md-6 col-lg-4">
        <select class="form-control"
          v-on:change="chooseNewWeapon"
          v-model="newWeapon">
          <option value="null" selected disabled>
            Add weapons / equipment</option>
          <option v-for="weapon, key in weaponsAvailable"
            :value="weapon"
          >{{ weapon.name }}</option>
        </select>
        <fighter-wargear
          :fighterIndex="index"
          :wargear="fighter.wargear"
          :weapons="fighter.weapons"
        ></fighter-wargear>
      </div>
      <div class="col col-12 col-md-6 col-lg-3">
        <fighter-stats :statstring="fighter.stats">
        </fighter-stats>
      </div>
      <div class="col col-12 col-md-6 col-lg-2">
        <em class="badge badge-info">{{ fighter.cost }} points</em>
      </div>
    </div>

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
        @newWeapon = null

      nameFighter: (name) ->
        @$store.commit "nameFighter",
          name: @fighter.name
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
