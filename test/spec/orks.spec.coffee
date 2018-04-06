import Vue from 'vue'

describe 'the orks roster', () ->

  it 'links to a faction roster', (done) ->
    @vm.$router.push 'build/shadowWar/orks'
    Vue.nextTick () =>
      expect(@words('h2')).toBe 'Ork Boyz Kill Team'
      done()

  it 'can have a nob with a kombi-shoota', (done) ->
    @all('.available-fighter-card button')[0].click()
    Vue.nextTick () =>
      wargear =  @get('select.add-wargear')
      expect(wargear.textContent).toContain 'Kombi-shoota'
      @change wargear, @option(wargear, 'Kombi-shoota')
      Vue.nextTick () =>
        expect(@all('.wargear-item .wargear-name')[2].textContent).toBe 'Kombi-shoota'
        done()

  it 'can exit cleanly and return to home', (done) ->
    @get('.action-btn').click()
    Vue.nextTick () =>
      @all('.modal-footer button')[0].click()
      Vue.nextTick () =>
        expect(@words('h2')).toBe 'Create a New Roster'
        done()
