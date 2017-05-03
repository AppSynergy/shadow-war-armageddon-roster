import Vue from 'vue'

describe 'the chaos roster', () ->

  it 'links to a faction roster', (done) ->
    @vm.$router.push 'build/chaos'
    Vue.nextTick () =>
      expect(@words('h2')).toBe 'Chaos Space Marine Kill Team'
      done()

  it 'can give marks of chaos', (done) ->
    @get('.available-fighter-card button').click()
    @all('.available-fighter-card button')[2].click()
    Vue.nextTick () =>
      expect(@all('.chosen-fighter-card').length).toBe 2
      expect(@get('select.add-wargear').textContent).toContain 'Mark of Khorne'
      expect(@get('select.add-wargear').textContent).toContain 'Mark of Nurgle'
      expect(@get('select.add-wargear').textContent).toContain 'Mark of Chaos Undivided'
      expect(@all('select.add-wargear')[1].textContent).not.toContain 'Mark of Nurgle'
      done()

  it 'can exit cleanly and return to home', (done) ->
    @get('a.router-link-active').click()
    Vue.nextTick () =>
      @all('.modal-footer button')[0].click()
      Vue.nextTick () =>
        expect(@words('h2')).toBe 'Create a New Roster'
        done()
