import Vue from 'vue'

describe 'the harlequins roster', () ->

  it 'links to a faction roster', (done) ->
    @vm.$router.push 'build/harlequins'
    Vue.nextTick () =>
      expect(@words('h2')).toBe 'Harlequin Troupe Kill Team'
      done()

  it 'can add a leader', (done) ->
    @all('.available-fighter-card button')[0].click()
    Vue.nextTick () =>
      expect(@all('.chosen-fighter-card').length).toBe 1
      done()

  it 'can add a trooper', (done) ->
    @all('.available-fighter-card button')[1].click()
    Vue.nextTick () =>
      expect(@all('.chosen-fighter-card').length).toBe 2
      done()

  it 'leader can have lots of weapons', () ->
    wargearText =  @all('select.add-wargear')[0].textContent
    expect(wargearText).toContain 'Power sword'
    expect(wargearText).toContain 'Harlequin\'s Embrace'
    expect(wargearText).toContain 'Fusion pistol'

  it 'trooper can only have some weapons', () ->
    wargearText =  @all('select.add-wargear')[1].textContent
    expect(wargearText).not.toContain 'Power sword'
    expect(wargearText).not.toContain 'Harlequin\'s Embrace'
    expect(wargearText).not.toContain 'Fusion pistol'
    expect(wargearText).toContain 'Shuriken pistol'

  it 'can exit cleanly and return to home', (done) ->
    @get('a.router-link-active').click()
    Vue.nextTick () =>
      @all('.modal-footer button')[0].click()
      Vue.nextTick () =>
        expect(@words('h2')).toBe 'Create a New Roster'
        done()
