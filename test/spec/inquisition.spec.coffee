import Vue from 'vue'

describe 'the craftworlds roster', () ->

  it 'links to a faction roster', (done) ->
    @vm.$router.push 'build/inquisition'
    Vue.nextTick () =>
      expect(2).toBe(2)
      expect(@words('h2')).toBe 'Inquisition Kill Team'
      done()

  it 'can add a trooper', (done) ->
    @all('.available-fighter-card button')[1].click()
    Vue.nextTick () =>
      expect(@all('.chosen-fighter-card').length).toBe 1
      expect(@get('.chosen-fighter-card .fighter-name').textContent).toBe 'Inquisitorial Acolyte'
      done()

  it 'can add extra weapon skill or ballistic skill', (done) ->
    wargear =  @get('select.add-wargear')
    expect(wargear.textContent).toContain '+1 Weapon Skill'
    expect(wargear.textContent).toContain '+1 Ballistic Skill'
    @change wargear, @option(wargear, 'Weapon Skill')
    Vue.nextTick () =>
      expect(wargear.textContent).not.toContain '+1 Weapon Skill'
      expect(wargear.textContent).not.toContain '+1 Ballistic Skill'
      expect(@get('.stats-vue td:nth-child(1)').textContent).toBe '4'
      done()

  it 'can exit cleanly and return to home', (done) ->
    @get('a.router-link-active').click()
    Vue.nextTick () =>
      @all('.modal-footer button')[0].click()
      Vue.nextTick () =>
        expect(@words('h2')).toBe 'Create a New Roster'
        done()
