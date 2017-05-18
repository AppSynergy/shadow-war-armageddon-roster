import Vue from 'vue'

describe 'the grey knights roster', () ->

  it 'links to a faction roster', (done) ->
    @vm.$router.push 'build/grey_knights'
    Vue.nextTick () =>
      expect(@words('h2')).toBe 'Grey Knights Kill Team'
      done()

  it 'can add a specialist', (done) ->
    @all('.available-fighter-card button')[2].click()
    Vue.nextTick () =>
      expect(@all('.chosen-fighter-card').length).toBe 1
      wargear = @get('select.add-wargear')
      @change wargear, @option(wargear, 'Psilencer')
      Vue.nextTick () =>
        expect(@all('.wargear-item').length).toBe 2
        expect(@all('.wargear-item')[0].textContent).toContain 'Power armour'
        expect(@all('.wargear-item')[1].textContent).toMatch /Psilencer\s*-\s*150 points/
        expect(wargear.textContent).toContain 'Weapon reload'
        done()

  it 'can add a weapon reload to a storm bolter', (done) ->
    @all('.available-fighter-card button')[1].click()
    Vue.nextTick () =>
      expect(@all('.chosen-fighter-card').length).toBe 2
      wargear = @all('select.add-wargear')[1]
      expect(wargear.textContent).toContain 'Weapon reload'
      done()

  it 'shows the correct items on roster view', (done) ->
    nav = @all('.navigation-vue .nav-item button')
    nav[3].click()
    Vue.nextTick () =>
      expect(@get('.roster-view-header h4').textContent).toBe 'Faction: Grey Knights'
      expect(@all('.items span.item').length).toBe 4
      expect(@all('.items span.item')[0].textContent).toContain 'Power armour'
      expect(@all('.items span.item')[1].textContent).toContain 'Psilencer'
      expect(@all('.items span.item')[2].textContent).toContain 'Storm bolter'
      expect(@all('.items span.item')[3].textContent).toContain 'Power armour'
      nav[2].click()
      Vue.nextTick () =>
        done()

  it 'can exit cleanly and return to home', (done) ->
    @get('.action-btn').click()
    Vue.nextTick () =>
      @all('.modal-footer button')[0].click()
      Vue.nextTick () =>
        expect(@words('h2')).toBe 'Create a New Roster'
        done()
