import Vue from 'vue'
import App from './App.vue'
import store from './store/roster.coffee'

new Vue({
  el: '#app',
  store,
  render: h => h(App)
})
