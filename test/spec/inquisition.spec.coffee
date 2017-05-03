import Vue from 'vue'

describe 'the inquisition roster', () ->

  it 'links to a faction roster', (done) ->
    @vm.$router.push 'build/inquisition'
    Vue.nextTick () =>
      expect(@words('h2')).toBe 'Inquisition Kill Team'
      done()

  it 'can add a trooper with +1 WS', (done) ->
    @all('.available-fighter-card button')[1].click()
    Vue.nextTick () =>
      expect(@all('.chosen-fighter-card').length).toBe 1
      expect(@get('.chosen-fighter-card .fighter-name').textContent).toBe 'Inquisitorial Acolyte (+1 WS)'
      expect(@all('.stats-vue td')[0].textContent).toBe '4'
      expect(@all('.stats-vue td')[1].textContent).toBe '4'
      expect(@all('.stats-vue td')[2].textContent).toBe '3'
      expect(@all('.stats-vue td')[3].textContent).toBe '3'
      expect(@all('.stats-vue td')[4].textContent).toBe '3'
      done()

  it 'can add a trooper with +1 BS', (done) ->
    @all('.available-fighter-card button')[2].click()
    Vue.nextTick () =>
      expect(@all('.chosen-fighter-card').length).toBe 2
      expect(@all('.chosen-fighter-card .fighter-name')[1].textContent).toBe 'Inquisitorial Acolyte (+1 BS)'
      expect(@all('.stats-vue td')[10].textContent).toBe '3'
      expect(@all('.stats-vue td')[11].textContent).toBe '4'
      done()

  it 'can exit cleanly and return to home', (done) ->
    @get('a.router-link-active').click()
    Vue.nextTick () =>
      @all('.modal-footer button')[0].click()
      Vue.nextTick () =>
        expect(@words('h2')).toBe 'Create a New Roster'
        done()
