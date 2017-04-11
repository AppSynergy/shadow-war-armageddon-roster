<template>
  <div class="fighter-vue">

    <button class="btn btn-danger px-1 py-0 remove-button"
      aria-label="Remove"
      v-on:click="removeFighter()">
      <i class="fa fa-times">&times;</i>
    </button>

    <div class="row">

      <div class="col col-12 col-md-6 col-lg-3 col-first">
        <input class="form-control mr-2" type="text"
          placeholder="Name me!"
          v-on:change="nameFighter"
          v-model="fighter.realName">
        <h4 class="mt-2 pl-2">{{ fighter.name }}</h4>
        <div class="mt-2 pl-2">{{ fighter.role}}</div>
        <em class="mt-2 ml-2 badge badge-info">{{ fighter.cost }} points</em>
      </div>

      <div class="col col-12 col-md-6 col-lg-4">
        <fighter-stats :statstring="fighter.stats">
        </fighter-stats>
      </div>

      <div class="col col-12 col-md-6 col-lg-5">
        <fighter-wargear
          :fighterIndex="index"
          :wargear="fighter.wargear"
          :weapons="fighter.weapons"
        ></fighter-wargear>
        <select class="form-control w-75 mt-2"
          v-on:change="chooseNewWeapon"
          v-model="newWeapon">
          <option value="null" selected disabled>
            Add weapons / equipment</option>
          <option v-for="weapon, key in weaponsAvailable"
            :value="weapon"
          >{{ weapon.name }} ({{ weapon.cost }})</option>
        </select>
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

    computed:
      fighter: () -> @$store.getters.getFighter @index

    methods:

      chooseNewWeapon: () ->
        if @newWeapon.key is 'weapon_reload' then @dealWithWeaponReload()
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

      dealWithWeaponReload: () ->
        old = _.clone @newWeapon
        weaponCost = _.max @fighter.weapons, (x) -> x.cost
        old.cost = Math.round(weaponCost.cost / 2)
        @newWeapon = old

  export default Fighter

</script>

<style lang="sass">
  .col-first .badge-info
    font-size: 140%
  .remove-button
    position: absolute
    right: 0.25em
    top: 0.25em
</style>
