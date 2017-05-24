<template>
  <nav class="navigation-vue navbar navbar-toggleable-sm navbar-inverse fixed-top bg-inverse">

    <button class="navbar-toggler navbar-toggler-right" type="button" data-toggle="collapse" data-target="#navbarCollapse" aria-controls="navbarCollapse" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>

    <a href="#" class="navbar-brand">killteams.com</a>

    <span class="navbar-text pt-2">
      <span class="text-white mr-4"><strong class="total-points-cost">{{ pointsCost }}</strong>&nbsp;{{ pluralize('point', pointsCost) }}</span><span class="text-white"><strong>{{ numberFighters }}</strong>&nbsp;{{ pluralize('model', numberFighters) }}</span>
    </span>

    <div class="collapse navbar-collapse" id="navbarCollapse">
      <ul class="navbar-nav ml-auto">
        <li class="nav-item">
          <router-link class="nav-link action-btn mx-auto text-white"
            to="/" tag="button">
            <i class="material-icons align-middle pb-1">home</i>
            <span>Home</span>
          </router-link>
        </li>
        <li class="nav-item">
          <button :class="buttonClass(!dirty)"
            :disabled="!dirty"
            v-if="$route.name == 'build'"
            v-on:click="saveRoster()">
            <i class="material-icons align-middle pb-1">save</i>
            <span>Save</span>
          </button>
        </li>
        <li class="nav-item">
          <router-link :class="buttonClass(empty)"
            tag="button"
            :to="'/build/'+factionId">
            <i class="material-icons align-middle pb-1">list</i>
            <span>Builder View</span>
          </router-link>
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

  </nav>
</template>

<script lang="coffee">

  StaticNav =

    props: ['factionId', 'empty', 'dirty', 'numberFighters', 'pointsCost']

    methods:

      pluralize: (str, i) ->
        if i == 1 then str else str + 's'

      buttonClass: (disabled) ->
        'nav-link action-btn mx-auto text-white': true
        'disabled': disabled

      saveRoster: () -> @$emit 'saveRoster'

  export default StaticNav

</script>
