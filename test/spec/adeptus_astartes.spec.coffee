import Vue from 'vue'

describe 'the space marine scouts roster', () ->

  it 'links to a faction roster', (done) ->
    @vm.$router.push 'build/adeptus_astartes'
    Vue.nextTick () =>
      expect(@words('h2')).toBe 'Adeptus Astartes Kill Team'
      done()

  it 'can add a scout', (done) ->
    @all('.available-fighter-card button')[1].click()
    Vue.nextTick () =>
      expect(@all('.chosen-fighter-card').length).toBe 1
      expect(@get('.fighter-cost').textContent).toBe '100 points'
      done()

  it 'can\'t add a weapon reload yet', (done) ->
    wargearText =  @get('select.add-wargear').textContent
    expect(wargearText).toContain 'Boltgun'
    expect(wargearText).toContain 'Shotgun'
    expect(wargearText).not.toContain 'Weapon reload'
    done()

  it 'can add a reload after taking a shotgun', (done) ->
    wargear = @get('select.add-wargear')
    @change wargear, @option(wargear, 'Shotgun')
    Vue.nextTick () =>
      expect(@get('.fighter-cost').textContent).toBe '120 points'
      expect(wargear.textContent).toContain 'Weapon reload'
      @change wargear, @option(wargear, 'Weapon reload')
      Vue.nextTick () =>
        expect(@all('.wargear-item')[2].textContent).toMatch /Shotgun -\s*20 points/
        expect(@all('.wargear-item')[3].textContent).toMatch /Weapon reload -\s*10 points/
        expect(@get('.fighter-cost').textContent).toBe '130 points'
        expect(@all('.wargear-item').length).toBe 4
        expect(@get('.total-points-cost').textContent).toBe '130'
        done()

  it 'should move the reload to the sniper rifle when replaced', (done) ->
    @all('.wargear-item button')[0].click()
    Vue.nextTick () =>
      wargear = @get('select.add-wargear')
      @change wargear, @option(wargear, 'Sniper rifle')
      Vue.nextTick () =>
        expect(@all('.wargear-item')[2].textContent).toMatch /Weapon reload -\s*20 points/
        expect(@all('.wargear-item')[3].textContent).toMatch /Sniper rifle -\s*40 points/
        expect(@get('.fighter-cost').textContent).toBe '160 points'
        done()

  it 'can exit cleanly and return to home', (done) ->
    @get('.action-btn').click()
    Vue.nextTick () =>
      @all('.modal-footer button')[0].click()
      Vue.nextTick () =>
        expect(@words('h2')).toBe 'Create a New Roster'
        done()
