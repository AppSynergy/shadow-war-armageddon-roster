<template>
  <div class="navigation-vue">
    <ul class="nav nav-justified" role="navigation">
      <li class="nav-item">
        <router-link class="nav-link action-btn mx-auto"
          to="/" tag="button">
          <i class="material-icons align-middle pb-1">home</i>
          <span>Home</span>
        </router-link>
      </li>
      <li class="nav-item">
        <button :class="buttonClass(!dirty)"
          :disabled="!dirty"
          v-on:click="saveRoster()">
          <i class="material-icons align-middle pb-1">save</i>
          <span>Save</span>
        </button>
      </li>
      <li class="nav-item">
        <router-link :class="buttonClass(empty)"
          :disabled="empty" tag="button"
          :to="'/roster-view/'+factionId">
          <i class="material-icons align-middle pb-1">print</i>
          <span>Roster View</span>
        </router-link>
      </li>
      <li class="nav-item">
        <router-link :class="buttonClass(empty)"
          :disabled="empty" tag="button"
          :to="'/simple-view/'+factionId">
          <i class="material-icons align-middle pb-1">assignment</i>
          <span>Simple View</span>
        </router-link>
      </li>
    </ul>
  </div>
</template>

<script lang="coffee">

  Navigation =

    props: ['factionId', 'empty', 'dirty']

    methods:

      buttonClass: (disabled) ->
        'nav-link action-btn mx-auto': true
        'disabled': disabled

      saveRoster: () -> @$emit 'saveRoster'

  export default Navigation

</script>
