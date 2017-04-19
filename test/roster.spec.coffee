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
      header = @words 'h2'
      expect(header).toBe 'Skitarii Ranger Kill Team'
      expect(@all('.available-fighter-card').length).toBe 4

      expect(@all('.chosen-fighter-card')).toBe 0

      addLeader = @get '.available-fighter-card button'
      e = document.createEvent('HTMLEvents')
      e.initEvent 'click', true, true
      #addLeader.dispatchEvent e

      Vue.nextTick () =>
        console.warn @all('.chosen-fighter-card')
        expect(@all('.chosen-fighter-card').length).toBe 1
        done()
