import Vue from 'vue'

describe 'the space wolves roster', () ->

  it 'links to a faction roster', (done) ->
    @vm.$router.push 'build/space_wolves'
    Vue.nextTick () =>
      expect(@words('h2')).toBe 'Wolf Scout Kill Team'
      done()

  it 'can take special weapons', (done) ->
    @all('.available-fighter-card button')[2].click()
    Vue.nextTick () =>
      wargear = @get('select.add-wargear')
      expect(wargear.textContent).toContain 'Meltagun'
      done()

  it 'can exit cleanly and return to home', (done) ->
    @get('a.router-link-active').click()
    Vue.nextTick () =>
      @all('.modal-footer button')[0].click()
      Vue.nextTick () =>
        expect(@words('h2')).toBe 'Create a New Roster'
        done()
