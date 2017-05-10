<template>
  <div class="wargear-vue">

    <div class="wargear-item d-inline-block mr-4 mb-1"
      v-for="item in maskedWargear">
      <span class="wargear-name">{{ item.name }}</span>
    </div>

    <div class="wargear-item d-inline-block mr-4 mb-1"
      v-for="weapon, index in weapons">
      <span class="wargear-name">{{ weapon.name }}</span> -
      <em class="badge badge-info">{{ weapon.cost }} points</em>
      <button class="btn btn-danger px-1 py-0"
        aria-label="Remove"
        v-on:click="removeWeapon(weapon, index)">
        <i class="fa fa-times">&times;</i>
      </button>
      <select v-if="weaponAttaches(weapon)">
        <option value="foo">This attaches!</option>
      </select>
    </div>

  </div>
</template>

<script lang="coffee">

  import Analytics from './mixin/Analytics.coffee'
  import MaskWargear from './mixin/MaskWargear.coffee'

  Wargear =

    mixins: [ Analytics, MaskWargear ]

    props: ['wargear', 'weapons', 'fighterIndex']

    computed:
      maskedWargear: () ->
        @maskWargearItems @weapons, @wargear

    methods:

      weaponAttaches: (weapon) ->
        if _.has weapon, 'only_attaches'
          couldAttachTo = _.filter @weapons, (x) ->
            _.contains weapon.only_attaches.values, x.role
          console.warn "Could attach to: ", _.map(couldAttachTo, (x) -> x.name)
          true
        else false

      removeWeapon: (weapon, index) ->
        @event 'remove_weapon', weapon.name
        @$store.commit 'removeWeapon',
          weaponIndex: index
          index: @fighterIndex
          cost: weapon.cost

  export default Wargear

</script>

<style lang="sass">
  .wargear-item
    position: relative
</style>
