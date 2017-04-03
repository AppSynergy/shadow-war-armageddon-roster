import Vue from 'vue'
import Vuex from 'vuex'

Vue.use(Vuex)

RosterStore =

  state:
    fighters: []

  mutations:
    addFighter: (state, fighter) ->
      state.fighters.push fighter
    removeFighter: (state, index) ->
      state.fighters.splice index, 1

store = new Vuex.Store RosterStore

export default store
