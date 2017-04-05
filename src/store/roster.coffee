import Vue from 'vue'
import Vuex from 'vuex'

Vue.use(Vuex)

RosterStore =

  state:
    teamName: ""
    fighters: []

  mutations:

    nameTeam: (state, name) ->
      state.teamName = name

    addFighter: (state, obj) ->
      fighter = obj.fighter
      fighter.realName = ""
      fighter.weapons = []
      fighter.wargear = fighter.wargear.map (x) -> obj.wargear[x]
      state.fighters.push fighter

    nameFighter: (state, obj) ->
      fighter = state.fighters[obj.index]
      fighter.name = obj.name

    removeFighter: (state, index) ->
      state.fighters.splice index, 1

    addWeapon: (state, obj) ->
      fighter = state.fighters[obj.index]
      fighter.weapons.push obj.weapon
      fighter.cost += obj.weapon.cost

    removeWeapon: (state, obj) ->
      fighter = state.fighters[obj.index]
      fighter.weapons.splice obj.weaponIndex, 1
      fighter.cost -= obj.cost

  getters:

    getFighters: (state) ->
      state.fighters

    getFighter: (state) -> (index) ->
      state.fighters[index]

    getTotalPointsCost: (state) ->
      state.fighters.reduce ((xs, x) -> xs + x.cost), 0

    getTotalNumberFighters: (state) ->
      state.fighters.length

    getNumberFightersByRole: (state) -> (role) ->
      state.fighters.filter((x) -> x.role == role).length

store = new Vuex.Store RosterStore

export default store
