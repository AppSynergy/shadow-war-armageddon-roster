<template>
  <div class="auth-vue card">

    <span v-if="user">
      <button class="btn btn-info"
        v-on:click="signout()">Sign out</button>
    </span>
    <span v-else>
      <button class="btn btn-info"
        v-on:click="signin(googleProvider)">Sign in with Google</button>
    </span>

  </div>
</template>

<script lang="coffee">

  import Firebase from 'firebase'

  Auth =
    data: () ->
      user: null
      googleProvider: new Firebase.auth.GoogleAuthProvider()

    mounted: () ->
      @watchUser()

    methods:

      signin: (provider) ->
        Firebase.auth().signInWithPopup provider
          .catch (error) ->
            console.warn "error signing in", error

      signout: () ->
        Firebase.auth().signOut()
          .catch (error) ->
            console.warn 'error signing out', error

      watchUser: () ->
        Firebase.auth().onAuthStateChanged (user) =>
          if user then @user = user
          else @user = null

  export default Auth

</script>
