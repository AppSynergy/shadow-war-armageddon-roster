import Vue from 'vue'
import App from './App.vue'
import store from './store/roster.coffee'
import VueRouter from 'vue-router'
import VueLocalStorage from 'vue-localstorage'
import jQuery from 'jquery'
import Bootstrap from 'bootstrap'

Vue.use(VueLocalStorage)
Vue.use(VueRouter)
require("font-awesome-sass-loader");

const router = new VueRouter([]);

new Vue({
  el: '#app',
  store,
  router,
  render: h => h(App)
})
