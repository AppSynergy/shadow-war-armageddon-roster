<template>
  <div class="fighter-vue">
    <div class="chosen-fighter-card card mb-4 fighter-background">

      <div class="card-header bg-inverse text-white">

          <span class="pr-4 mt-2 d-inline-block align-middle fighter-name"><strong>{{ fighter.name }}</strong></span>
          <span class="pr-4 mt-2 d-inline-block align-middle hidden-sm-down">{{ fighter.role}}</span>
          <span class="float-right">
            <em class="fighter-cost mr-4">{{ fighterCost() }} points</em>
            <button class="btn btn-info px-1 py-0 duplicate-button"
              aria-label="Duplicate"
              title="Duplicate"
              v-on:click="duplicateFighter()">
              <i class="material-icons p-1">content_copy</i>
            </button>
            <button class="btn btn-danger px-1 py-0 remove-button"
              aria-label="Delete Fighter"
              title="Delete Fighter"
              v-on:click="removeFighter()">
              <i class="material-icons p-1">delete_forever</i>
            </button>
          </span>

      </div>

      <div class="card-block">
        <div class="row">

          <div class="col col-12 col-md-5 col-lg-4">
            <input class="form-control mb-3" type="text"
              placeholder="Name me!"
              v-on:change="nameFighter"
              v-model="fighter.realName">
            <fighter-stats :statstring="fighter.stats"
              :statmasks="statMasks(fighter)">
            </fighter-stats>
          </div>

          <div class="col col-12 col-md-7 col-lg-8">
            <select class="form-control add-wargear mb-3"
              v-on:change="chooseNewWeapon"
              v-model="newWeapon">
              <option value="null" selected disabled>
                Add weapons / equipment</option>
              <optgroup v-for="items, role in weaponsByRole"
                :label="roles[role].name">
                <option v-for="weapon, key in items" :value="weapon"
                  >{{ weapon.name }} ({{ weapon.cost }})</option>
              </optgroup>
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
  import RoleData from '../data/roles.toml'

  Fighter =

    components: { FighterStats, FighterWargear }

    mixins: [ Analytics ]

    props: ['index', 'weaponsAvailable', 'trueCost']

    data: () ->
      newWeapon: null

    computed:
      roles: () -> RoleData
      fighter: () -> @$store.getters.getFighter @index
      weaponsByRole: () -> _.groupBy @weaponsAvailable, (x) -> x.role

    methods:

      fighterCost: (fighter) ->
        @$store.getters.getFighterCost @index, @trueCost

      chooseNewWeapon: () ->
        @event 'add_weapon', @newWeapon.name
        if @newWeapon.key is 'weapon_reload' then @dealWithWeaponReload()
        @$store.commit "addWeapon",
         weapon: @newWeapon
         index: @index
        @newWeapon = null

      nameFighter: (name) ->
        @event 'name_fighter', @fighter.realName
        @$store.commit 'dirtyState'

      duplicateFighter: () ->
        @$emit 'duplicateFighter', @fighter

      removeFighter: () ->
        @event 'remove_fighter', @fighter.name
        @$store.commit 'removeFighter', @index

      dealWithWeaponReload: () ->
        old = _.clone @newWeapon
        weaponCost = _.max @fighter.weapons, (x) -> x.cost
        old.cost = Math.round(weaponCost.cost / 2)
        @newWeapon = old

      statMasks: (fighter) ->
        _.filter fighter.weapons, (x) -> _.has x, 'stat_mask'
        .map (x) -> x.stat_mask


  export default Fighter

</script>
