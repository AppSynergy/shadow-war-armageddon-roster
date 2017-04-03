import Vue from 'vue'
import App from './App.vue'
import store from './store/roster.coffee'

require("font-awesome-sass-loader");

new Vue({
  el: '#app',
  store,
  render: h => h(App)
})
