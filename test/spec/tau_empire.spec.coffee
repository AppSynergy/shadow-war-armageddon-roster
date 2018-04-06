import Vue from 'vue'

describe 'the tau roster', () ->

  it 'links to a faction roster', (done) ->
    @vm.$router.push 'build/shadowWar/tau_empire'
    Vue.nextTick () =>
      expect(@words('h2')).toBe 'Tau Pathfinder Kill Team'
      done()

  it 'can add a specialist with rifle options', (done) ->
    expect(@all('.chosen-fighter-card').length).toBe 0
    @all('.available-fighter-card button')[3].click()
    Vue.nextTick () =>
      expect(@all('.chosen-fighter-card').length).toBe 1
      wargearText =  @get('select.add-wargear').textContent
      expect(wargearText).toContain 'Ion rifle'
      expect(wargearText).toContain 'Rail rifle'
      expect(wargearText).toContain 'Photon grenades'
      done()

  it 'lists the right wargear', () ->
    expect(@all('.wargear-item .wargear-name')[0].textContent).toBe 'Combat blade'
    expect(@all('.wargear-item .wargear-name')[1].textContent).toBe 'Recon armour'

  it 'can take weapon reloads on the right items', (done) ->
    wargear = @get('select.add-wargear')
    expect(@all('.wargear-item').length).toBe 2
    expect(wargear.textContent).not.toContain 'Weapon reload'
    @change wargear, @option(wargear, 'Ion rifle')
    Vue.nextTick () =>
      wargear = @get('select.add-wargear')
      expect(wargear.textContent).toContain 'Weapon reload'
      @change wargear, @option(wargear, 'Weapon reload')
      Vue.nextTick () =>
        expect(@all('.wargear-item').length).toBe 4
        expect(@all('.wargear-item')[2].textContent).toMatch /Ion rifle\s*-\s*100 points/
        expect(@all('.wargear-item')[3].textContent).toMatch /Weapon reload for Ion rifle\s*-\s*50 points/
        done()

  it 'can duplicate an existing fighter', (done) ->
    @get('.duplicate-button').click()
    Vue.nextTick () =>
      expect(@all('.chosen-fighter-card').length).toBe 2
      expect(@all('.wargear-item').length).toBe 8
      expect(@all('.wargear-item')[6].textContent).toMatch /Ion rifle\s*-\s*100 points/
      done()

  it 'can exit cleanly and return to home', (done) ->
    @get('.action-btn').click()
    Vue.nextTick () =>
      @all('.modal-footer button')[0].click()
      Vue.nextTick () =>
        expect(@words('h2')).toBe 'Create a New Roster'
        done()
