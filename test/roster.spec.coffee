import 'es6-promise/auto'
import Vue from 'vue'
import App from '../src/App.vue'
import store from '../src/store/roster.coffee'
import VueRouter from 'vue-router'
import VueLocalStorage from 'vue-localstorage'

Vue.use(VueLocalStorage)
Vue.use(VueRouter)

router = new VueRouter([])



describe 'sanity test', () ->
  it 'can do math', () ->
    expect(2+2).toBe 4


describe 'App.vue', () ->

  words = (vm, selector) ->
    vm.$el.querySelector(selector).textContent

  beforeEach () ->
    @vm = new Vue({
      template: '<div><test></test></div>'
      components: { 'test': App }
      router
      store
    }).$mount()

  it 'loads the right route', () ->
    expect(words(@vm, 'h2')).toBe 'Create a New Roster'

  it 'loads factions', () ->
    factions = @vm.$el.querySelectorAll '.faction-card'
    expect(factions.length).toBe 10
    expect(factions[0].textContent).toBe 'Skitarii'

  it 'links to a faction roster', (done) ->
    @vm.$router.push 'build/skitarii'
    Vue.nextTick () =>
      expect(words(@vm, 'h2')).toBe 'Skitarii Ranger Kill Team'
      done()
