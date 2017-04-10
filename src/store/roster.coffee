import Vue from 'vue'
import Vuex from 'vuex'

Vue.use(Vuex)

RosterStore =

  state:
    dirty: false
    teamName: ""
    fighters: []

  mutations:

    cleanState: (state) ->
      state.dirty = false

    discardRoster: (state) ->
      state.teamName = ""
      state.fighters = []

    loadRoster: (state, obj) ->
      state.teamName = obj.teamName
      state.fighters = obj.fighters

    nameTeam: (state, name) ->
      state.dirty = true
      state.teamName = name

    addFighter: (state, obj) ->
      state.dirty = true
      fighter = obj.fighter
      fighter.realName = ""
      fighter.weapons = []
      fighter.wargear = fighter.wargear.map (x) -> obj.wargear[x]
      state.fighters.push fighter

    nameFighter: (state, obj) ->
      state.dirty = true
      fighter = state.fighters[obj.index]
      fighter.name = obj.name

    removeFighter: (state, index) ->
      state.dirty = true
      state.fighters.splice index, 1

    addWeapon: (state, obj) ->
      state.dirty = true
      fighter = state.fighters[obj.index]
      fighter.weapons.push obj.weapon
      fighter.cost += obj.weapon.cost

    removeWeapon: (state, obj) ->
      state.dirty = true
      fighter = state.fighters[obj.index]
      fighter.weapons.splice obj.weaponIndex, 1
      fighter.cost -= obj.cost

  getters:

    getDirty: (state) ->
      state.dirty

    getTeamName: (state) ->
      state.teamName

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
