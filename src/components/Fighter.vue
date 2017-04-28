<template>
  <div class="fighter-vue">
    <div class="chosen-fighter-card card mb-4 fighter-background">

      <div class="card-header bg-inverse text-white">
        <h4 class="m-0">
          <span class="pr-4 fighter-name"><strong>{{ fighter.name }}</strong></span>
          <span class="pr-4">{{ fighter.role}}</span>
          <span class="float-right">
            <em class="badge badge-info mr-4">{{ fighter.cost }} points</em>
            <button class="btn btn-danger px-1 py-0 remove-button"
              aria-label="Remove"
              v-on:click="removeFighter()">
              <i class="fa fa-times">&times;</i>
            </button>
          </span>
        </h4>
      </div>

      <div class="card-block">
        <div class="row">

          <div class="col col-12 col-md-5 col-lg-4">
            <input class="form-control mb-3" type="text"
              placeholder="Name me!"
              v-on:change="nameFighter"
              v-model="fighter.realName">
            <fighter-stats :statstring="fighter.stats"
              :statchanges="statChanges(fighter)">
            </fighter-stats>
          </div>

          <div class="col col-12 col-md-7 col-lg-8">
            <select class="form-control add-wargear mb-3"
              v-on:change="chooseNewWeapon"
              v-model="newWeapon">
              <option value="null" selected disabled>
                Add weapons / equipment</option>
              <option v-for="weapon, key in weaponsAvailable"
                :value="weapon"
              >{{ weapon.name }} ({{ weapon.cost }})</option>
            </select>
            <fighter-wargear class="fighter-wargear"
              :fighterIndex="index"
              :wargear="fighter.wargear"
              :weapons="fighter.weapons"
            ></fighter-wargear>
          </div>

        </div>
      </div>

    </div>
  </div>
</template>

<script lang="coffee">

  import Analytics from './mixin/Analytics.coffee'
  import FighterStats from './Stats.vue'
  import FighterWargear from './Wargear.vue'

  Fighter =

    components: { FighterStats, FighterWargear }

    mixins: [ Analytics ]

    props: ['index', 'weaponsAvailable']

    data: () ->
      newWeapon: null

    computed:
      fighter: () -> @$store.getters.getFighter @index

    methods:

      chooseNewWeapon: () ->
        @event 'add_weapon', @newWeapon.name
        if @newWeapon.key is 'weapon_reload' then @dealWithWeaponReload()
        @$store.commit "addWeapon",
         weapon: @newWeapon
         index: @index
        @newWeapon = null

      nameFighter: (name) ->
        @event 'name_fighter', @fighter.realName

      removeFighter: () ->
        @event 'remove_fighter', @fighter.name
        @$store.commit 'removeFighter', @index

      dealWithWeaponReload: () ->
        old = _.clone @newWeapon
        weaponCost = _.max @fighter.weapons, (x) -> x.cost
        old.cost = Math.round(weaponCost.cost / 2)
        @newWeapon = old

      statChanges: (fighter) ->
        _.filter fighter.weapons, (x) -> _.has x, 'stat_change'
          .map (x) -> x.stat_change

  export default Fighter

</script>
