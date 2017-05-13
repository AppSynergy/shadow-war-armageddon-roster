<template>
  <div class="wargear-vue">

    <div class="wargear-item d-inline-block mr-4 mb-1"
      v-for="item in maskedWargear">
      <span class="wargear-name">{{ item.name }}</span>
    </div>

    <div class="wargear-item d-inline-block mr-4 mb-1 form-inline"
      v-for="weapon, index in weapons">
      <span class="wargear-name">{{ weapon.name }}</span>
      <template v-if="weaponAttaches(weapon)">
        <span>for</span>
        <select class="form-control form-control-sm"
          v-model="weapon.attached_to" v-on:change="updateAttachee(weapon, index)">
          <option v-for="parent in couldAttachTo(weapon)"
            :value="parent">{{ parent.name }}
          </option>
        </select>
      </template> -
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

  import Analytics from './mixin/Analytics.coffee'
  import AttachToWeapon from './mixin/AttachToWeapon.coffee'
  import MaskWargear from './mixin/MaskWargear.coffee'
  import Vue from 'vue'

  Wargear =

    mixins: [ Analytics, AttachToWeapon, MaskWargear ]

    props: ['wargear', 'weapons', 'fighterIndex']

    computed:
      maskedWargear: () ->
        @maskWargearItems @weapons, @wargear

    methods:

      updateAttachee: (weapon, index) ->
        if weapon.name = "Weapon reload" && weapon.attached_to
          weapon.cost = Math.round(weapon.attached_to.cost / 2)
        @$store.commit 'updateWeapon',
          weaponIndex: index
          index: @fighterIndex
          weapon: weapon

      removeWeapon: (weapon, index) ->
        @event 'remove_weapon', weapon.name
        @$store.commit 'removeWeapon',
          weaponIndex: index
          index: @fighterIndex
        @removeAttachments weapon

      removeAttachments: (weapon) ->
        wasAttached = _.filter @weapons, (x) -> _.has(x, 'attached_to') && x.attached_to.name == weapon.name
        if wasAttached.length > 0
          _.each wasAttached, (attachment) =>
            index = _.findIndex @weapon, (x) -> x.name == attachment.name
            couldAttach = @couldAttachTo attachment
            if couldAttach.length > 0
              attachment.attached_to = couldAttach[0]
              @updateAttachee attachment, index

  export default Wargear

</script>

<style lang="sass">
  .wargear-item
    position: relative
</style>
