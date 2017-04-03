<template>
  <div class="wargear-vue">
    <div class="row mb-4">
      <div class="col col-6 col-md-4 col-lg-3"
        v-for="weapon, index in wargearAndWeapons">
        <h5>{{ weapon.name }}</h5>
        <template v-if="weapon.cost">
          <em>{{ weapon.cost }} points</em>
          <button class="btn btn-danger p-1"
            v-on:click="removeWeapon(weapon, index)">Remove</button>
        </template>
      </div>
    </div>
  </div>
</template>

<script lang="coffee">

  Wargear =
    props: ['wargear', 'weapons', 'fighterIndex']

    computed:
      wargearAndWeapons: () ->
        @weapons
        # maybe, but then index is wrong :S
        #@wargear.map (x) -> {name: x}
        #.concat @weapons

    methods:

      removeWeapon: (weapon, index) ->
        @$store.commit 'removeWeapon',
          weaponIndex: index
          index: @fighterIndex
          cost: weapon.cost

  export default Wargear

</script>
