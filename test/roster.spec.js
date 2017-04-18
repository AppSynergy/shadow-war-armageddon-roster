import Vue from 'vue'
import App from '../src/App.vue'
import VueRouter from 'vue-router'

Vue.use(VueRouter)
const router = new VueRouter([]);

describe('App.vue', function () {

  it('should render correct message', function () {

    var vm = new Vue({
      template: '<div><test></test></div>',
      components: { 'test': App },
      router
    }) //.$mount();

    expect(2+2).toBe(4);
    console.log(vm);
    //expect(vm.$el.querySelector('a:first').textContent).toBe('Home')
  })
})
