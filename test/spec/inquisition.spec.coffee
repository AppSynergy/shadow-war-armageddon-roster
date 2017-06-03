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
      expect(@get('.chosen-fighter-card .fighter-name').textContent).toBe 'Inquisitorial Acolyte'
      wargear = @get 'select.add-wargear'
      @change wargear, @option(wargear, 'Weapon Skill')
      Vue.nextTick () =>
        expect(@all('.stats-vue td')[0].textContent).toContain '4'
        expect(@all('.stats-vue td')[1].textContent).toContain '4'
        expect(@all('.stats-vue td')[2].textContent).toContain '3'
        expect(@all('.stats-vue td')[3].textContent).toContain '3'
        done()

  it 'can add a trooper with +1 BS', (done) ->
    @all('.available-fighter-card button')[1].click()
    Vue.nextTick () =>
      wargear = @all('select.add-wargear')[1]
      @change wargear, @option(wargear, 'Ballistic Skill')
      Vue.nextTick () =>
        expect(@all('.chosen-fighter-card').length).toBe 2
        expect(@all('.stats-vue td')[9].textContent).toContain '4'
        expect(@all('.stats-vue td')[10].textContent).toContain '3'
        expect(@all('.stats-vue td')[11].textContent).toContain '4'
        expect(@all('.stats-vue td')[12].textContent).toContain '3'
        done()

  it 'can activate campaign mode and make further stat changes', (done) ->
    expect(@all('i.change-stat').length).toBe 0
    @get('.campaignMode').click()
    Vue.nextTick () =>
      expect(@all('i.change-stat').length).toBe 36
      expect(@all('.stats-vue td')[0].textContent).toContain '4'
      @all('i.change-stat')[0].click()
      Vue.nextTick () =>
        expect(@all('.stats-vue td')[0].textContent).toContain '5'
        @all('i.change-stat')[1].click()
        @all('i.change-stat')[1].click()
        @all('i.change-stat')[1].click()
        Vue.nextTick () =>
          expect(@all('.stats-vue td')[0].textContent).toContain '2'
          done()


  it 'can exit cleanly and return to home', (done) ->
    @get('.action-btn').click()
    Vue.nextTick () =>
      @all('.modal-footer button')[0].click()
      Vue.nextTick () =>
        expect(@words('h2')).toBe 'Create a New Roster'
        done()
