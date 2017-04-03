<template>
  <div class="fighter-vue">
    <div class="row">

      <div class="col col-2">
        <h4>{{ fighter.name }}</h4>

        <label for="chooseNewWeapon">Add weapons:</label>
        <select class="" name="chooseNewWeapon"
          v-model="chooseNewWeapon">
          <option>-- choose one --</option>
          <option v-for="weapon, key in weaponsAvailable"
            :value="weapon"
          >{{ weapon.name }}</option>
        </select>
      </div>

      <div class="col col-2">
        <em>{{ fighter.cost }} points</em>
        <div v-for="weapon, index in weapons">
          <span title="weapon.desc">
            {{ weapon.name }}
          </span>
          <em>{{ weapon.cost }} points</em>
          <button class="btn btn-danger"
            v-on:click="removeWeapon(index)">Remove</button>
        </div>
      </div>

      <div class="col col-6">
        <fighter-stats :statstring="fighter.stats">
        </fighter-stats>
      </div>

      <div class="col col-2">
        <button class="btn btn-danger"
          v-on:click="removeFighter(index)">Remove</button>
      </div>

    </div>
  </div>
</template>

<script lang="coffee">

  import FighterStats from './Stats.vue'

  Fighter =

    components: { FighterStats }

    props: ['fighter', 'index', 'weaponsAvailable']

    data: () ->
      chooseNewWeapon: null
      weapons: []

    watch:
      chooseNewWeapon: (weapon) ->
        @weapons.push weapon

    methods:

      removeFighter: (index) ->
        @$emit 'removeFighterIndex', index

      removeWeapon: (index) ->
        @weapons.splice index, 1

  export default Fighter

</script>
