import Vue from 'vue'
import Vuex from 'vuex'

deepClone = (x) -> JSON.parse JSON.stringify(x)

Vue.use(Vuex)

RosterStore =

  state:
    dirty: false
    teamName: ""
    fighters: []

  mutations:

    dirtyState: (state) ->
      state.dirty = true

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
      fighter = deepClone obj.fighter
      fighter.realName = ""
      fighter.baseCost = fighter.cost
      fighter.weapons = []
      fighter.wargear = fighter.wargear.map (x) ->
        gear = obj.wargear[x]
        gear.key = x
        gear
      fighter.campaign = {}
      fighter.campaign.statmask = "0 0 0 0 0 0 0 0 0"
      state.fighters.push fighter

    duplicateFighter: (state, fighter) ->
      state.dirty = true
      state.fighters.push deepClone(fighter)

    updateFighters: (state, fighters) ->
      state.dirty = true
      state.fighters = fighters

    increaseCampaignStat: (state, obj) ->
      state.dirty = true
      fighter = state.fighters[obj.index]
      a = fighter.campaign.statmask.split ' '
      a[obj.statIndex] = (parseInt(a[obj.statIndex], 10) + 1).toString()
      fighter.campaign.statmask = a.join ' '

    decreaseCampaignStat: (state, obj) ->
      state.dirty = true
      fighter = state.fighters[obj.index]
      a = fighter.campaign.statmask.split ' '
      a[obj.statIndex] = (parseInt(a[obj.statIndex], 10) - 1).toString()
      fighter.campaign.statmask = a.join ' '

    removeFighter: (state, index) ->
      state.dirty = true
      state.fighters.splice index, 1

    addWeapon: (state, obj) ->
      state.dirty = true
      fighter = state.fighters[obj.index]
      fighter.weapons.push obj.weapon

    updateWeapon: (state, obj) ->
      state.dirty = true
      fighter = state.fighters[obj.index]
      fighter.weapons[obj.weaponIndex] = obj.weapon

    removeWeapon: (state, obj) ->
      state.dirty = true
      fighter = state.fighters[obj.index]
      fighter.weapons.splice obj.weaponIndex, 1

  getters:

    getDirty: (state) ->
      state.dirty

    getTeamName: (state) ->
      state.teamName

    getFighters: (state) ->
      state.fighters

    getFighter: (state) -> (index) ->
      state.fighters[index]

    getFighterCost: (state) -> (index) ->
      fighter = state.fighters[index]
      weaponCost = _.reduce fighter.weapons, ((xs, x) -> xs + x.cost), 0
      fighter.baseCost + weaponCost

    getTotalPointsCost: (state) ->
      state.fighters.reduce ((xs, x) ->
        weaponCost = _.reduce x.weapons, ((ys, y) -> ys + y.cost), 0
        xs + x.baseCost + weaponCost
      ), 0

    getTotalNumberFighters: (state) ->
      state.fighters.length

    getNumberFightersByRole: (state) -> (role) ->
      state.fighters.filter((x) -> x.role == role).length

store = new Vuex.Store RosterStore

export default store
