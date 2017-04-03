<template>
  <div class="wargear-vue">
    <div class="row mb-4">

      <div class="col col-6 col-md-4 col-lg-3"
        v-for="item in wargear">
        <div class="card">
          <h5>{{ item.name }}</h5>
        </div>
      </div>

      <div class="col col-6 col-md-4 col-lg-3"
        v-for="weapon, index in weapons">
        <div class="card">
          <h5>{{ weapon.name }}</h5>
          <em>{{ weapon.cost }} points</em>
          <button class="btn btn-danger p-1 remove-button"
            aria-label="Remove"
            v-on:click="removeWeapon(weapon, index)">
            <i class="fa fa-times"></i>
          </button>
        </div>
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
