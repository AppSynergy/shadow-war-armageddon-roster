<template>
  <div class="wargear-vue">

    <div class="wargear-item d-inline-block mr-4 mb-1"
      v-for="item in wargear">
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
    </div>

  </div>
</template>

<script lang="coffee">

  Wargear =

    props: ['wargear', 'weapons', 'fighterIndex']

    methods:

      removeWeapon: (weapon, index) ->
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
