<template>
  <div class="wargear-vue">

    <div class="wargear-item"
      v-for="item in wargear">
      <span>{{ item.name }}</span>
    </div>

    <div class="wargear-item"
      v-for="weapon, index in weapons">
      <span>
        {{ weapon.name }} -
        <em class="badge badge-info">{{ weapon.cost }} points</em>
      </span>
      <button class="btn btn-danger p-1 remove-button"
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
