import 'es6-promise/auto'
import Vue from 'vue'
import App from '../src/App.vue'
import store from '../src/store/roster.coffee'
import VueRouter from 'vue-router'
import VueLocalStorage from 'vue-localstorage'
import jQuery from 'jquery'
import 'underscore'

Vue.use(VueLocalStorage)
Vue.use(VueRouter)

router = new VueRouter([])


describe 'sanity test', () ->
  it 'can do math', () ->
    expect(2+2).toBe 4


describe 'App.vue', () ->

  beforeEach () ->
    @vm = new Vue({
      template: '<div><test></test></div>'
      components: { 'test': App }
      router
      store
    }).$mount()
    @dom = @vm.$el
    @all = (selector) => @dom.querySelectorAll selector
    @get = (selector) => @dom.querySelector selector
    @words = (selector) => @dom.querySelector(selector).textContent
    @option = (ele, text) ->
      for i in [0..(ele.length-1)]
        re = new RegExp text
        se = ele[i].textContent.search re
        return i if se >= 0
      return undefined
    @change = (ele, index) ->
      ele.selectedIndex = index
      ele.dispatchEvent(new Event('change'))


  it 'loads the right route', () ->
    header = @words 'h2'
    expect(header).toBe 'Create a New Roster'

  it 'loads factions', () ->
    factions = @all '.faction-card'
    expect(factions.length).toBe 10
    expect(factions[0].textContent).toBe 'Skitarii'
    expect(factions[9].textContent).toBe 'Genestealer Cults'

  it 'links to a faction roster', (done) ->
    @vm.$router.push 'build/skitarii'
    Vue.nextTick () =>
      expect(@words('h2')).toBe 'Skitarii Ranger Kill Team'
      expect(@all('.available-fighter-card').length).toBe 4
      expect(@all('.chosen-fighter-card').length).toBe 0
      done()

  it 'can add a fighter', (done) ->
    @get('.available-fighter-card button').click()
    Vue.nextTick () =>
      expect(@all('.chosen-fighter-card').length).toBe 1
      done()

  it 'has wargear loaded', () ->
    expect(@all('.wargear-item').length).toBe 2
    expect(@all('.wargear-item .wargear-name')[0].textContent).toBe 'Combat blade'

  it 'cannot add weapons that don\'t exist', () ->
    expect(@option(@get('select.add-wargear'), 'Spoon grenades!')).toBeUndefined()

  it 'can add weapons', (done) ->
    wargear = @get('select.add-wargear')
    @change wargear, @option(wargear, 'Krak grenades')
    Vue.nextTick () =>
      expect(@all('.wargear-item').length).toBe 3
      expect(@all('.wargear-item .wargear-name')[2].textContent).toBe 'Krak grenades'
      done()

  it 'lists the right wargear options', () ->
    expect(@all('select.add-wargear option').length).toBe 17
    wargearText =  @get('select.add-wargear').textContent
    expect(wargearText).toContain 'Arc maul'
    expect(wargearText).toContain 'Phosphor blast pistol'
    expect(wargearText).not.toContain 'Hamburger'

  it 'cannot add a second leader', (done) ->
    @all('.available-fighter-card button')[0].click()
    Vue.nextTick () =>
      expect(@all('.chosen-fighter-card').length).toBe 1
      done()

  it 'can add a trooper', (done) ->
    @all('.available-fighter-card button')[1].click()
    Vue.nextTick () =>
      expect(@all('.chosen-fighter-card').length).toBe 2
      expect(@option(@all('select.add-wargear')[1], 'Radium carbine')).toBeGreaterThan -1
      done()

  it 'doesn\'t give the trooper the leader only weapons', () ->
    expect(@option(@all('select.add-wargear')[1], 'Phosphor blast pistol')).toBeUndefined()

  it 'only gives telescopic sight if you have a rifle first', (done) ->
    trooperWargear = @all('select.add-wargear')[1]
    expect(@option(trooperWargear, 'Telescopic sight')).toBeUndefined()
    @change trooperWargear, @option(trooperWargear, 'Galvanic rifle')
    Vue.nextTick () =>
      expect(@option(trooperWargear, 'Telescopic sight')).toBeGreaterThan -1
      done()
