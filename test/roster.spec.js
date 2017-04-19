import 'es6-promise/auto'
import Vue from 'vue'
import App from '../src/App.vue'
import store from '../src/store/roster.coffee'
import VueRouter from 'vue-router'
import VueLocalStorage from 'vue-localstorage'

Vue.use(VueLocalStorage)
Vue.use(VueRouter)

const router = new VueRouter([]);

describe('App.vue', function () {

  it('can do math', function () {
    expect(2+2).toBe(4)
  })

  it('should render correct message', function () {

    var vm = new Vue({
      template: '<div><test></test></div>',
      components: { 'test': App },
      router,
      store
    }).$mount();


    expect(vm.$el.querySelector('h2').textContent).toBe('Create a New Roster')
    var factions = vm.$el.querySelectorAll('.faction-card')
    expect(factions.length).toBe(10)
    expect(factions[0].textContent).toBe('Skitarii')
  })
})
