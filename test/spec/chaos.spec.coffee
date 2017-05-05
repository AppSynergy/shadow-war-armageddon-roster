import Vue from 'vue'

describe 'the chaos roster', () ->

  it 'links to a faction roster', (done) ->
    @vm.$router.push 'build/chaos'
    Vue.nextTick () =>
      expect(@words('h2')).toBe 'Chaos Space Marine Kill Team'
      done()

  it 'can give marks of chaos to those who deserve them', (done) ->
    @get('.available-fighter-card button').click()
    @all('.available-fighter-card button')[2].click()
    Vue.nextTick () =>
      expect(@all('.chosen-fighter-card').length).toBe 2
      wargear = @get('select.add-wargear')
      expect(wargear.textContent).toContain 'Mark of Khorne'
      expect(wargear.textContent).toContain 'Mark of Nurgle'
      expect(wargear.textContent).toContain 'Mark of Chaos Undivided'
      expect(@all('select.add-wargear')[1].textContent).not.toContain 'Mark of Nurgle'
      done()

  it 'gets more attacky with a mark of khorne', (done) ->
    wargear = @get('select.add-wargear')
    expect(@all('.stats-vue td')[7].textContent).toBe '2'
    @change wargear, @option(wargear, 'Mark of Khorne')
    Vue.nextTick () =>
      expect(@all('.stats-vue td')[7].textContent).toBe '3'
      expect(@all('.stats-vue td')[8].textContent).toBe '9'
      done()

  it 'can exit cleanly and return to home', (done) ->
    @get('.action-btn').click()
    Vue.nextTick () =>
      @all('.modal-footer button')[0].click()
      Vue.nextTick () =>
        expect(@words('h2')).toBe 'Create a New Roster'
        done()
