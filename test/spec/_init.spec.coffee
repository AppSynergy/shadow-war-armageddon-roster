import 'es6-promise/auto'
import Vue from 'vue'
import App from '../../src/App.vue'
import store from '../../src/store/roster.coffee'
import VueRouter from 'vue-router'
import VueLocalStorage from 'vue-localstorage'
import Draggable from 'vuedraggable'
import jQuery from 'jquery'
import Bootstrap from 'bootstrap'
import 'underscore'
import 'babel-polyfill'

Vue.use(VueLocalStorage)
Vue.use(VueRouter)

router = new VueRouter([])

beforeAll () ->
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
