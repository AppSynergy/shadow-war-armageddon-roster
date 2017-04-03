<template>
  <div class="wargear-vue">
    <div class="row mb-4">
      <div class="col col-6 col-md-4 col-lg-3"
        v-for="weapon, index in weapons">
        <h5>{{ weapon.name }}</h5>
        <em>{{ weapon.cost }} points</em>
        <button class="btn btn-danger p-1"
          v-on:click="removeWeapon(weapon, index)">Remove</button>
      </div>
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
