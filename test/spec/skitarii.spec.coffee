import Vue from 'vue'

describe 'basic roster operations', () ->

  it 'loads the right route', (done) ->
    @vm.$router.push '/'
    Vue.nextTick () =>
      expect(@words('h2')).toBe 'Create a New Roster'
      done()

  it 'loads factions', () ->
    factions = @all '.roster-new .card'
    expect(factions.length).toBe 24
    expect(factions[0].textContent).toBe 'House Escher'
    expect(factions[6].textContent).toBe 'Chaos Cult Gang'
    expect(factions[17].textContent).toBe 'Genestealer Cults'

  it 'links to a faction roster', (done) ->
    @vm.$router.push 'build/shadowWar/skitarii'
    Vue.nextTick () =>
      expect(@words('h2')).toBe 'Skitarii Ranger Kill Team'
      expect(@all('.available-fighter-card').length).toBe 4
      expect(@all('.chosen-fighter-card').length).toBe 0
      done()

  it 'can add a fighter', (done) ->
    @get('.available-fighter-card button').click()
    Vue.nextTick () =>
      expect(@all('.chosen-fighter-card').length).toBe 1
      done()

  it 'has wargear loaded', () ->
    expect(@all('.wargear-item').length).toBe 2
    expect(@all('.wargear-item .wargear-name')[0].textContent).toBe 'Combat blade'

  it 'cannot add weapons that don\'t exist', () ->
    expect(@option(@get('select.add-wargear'), 'Spoon grenades!')).toBeUndefined()

  it 'can add weapons', (done) ->
    wargear = @get('select.add-wargear')
    @change wargear, @option(wargear, 'Krak grenades')
    Vue.nextTick () =>
      expect(@all('.wargear-item').length).toBe 3
      expect(@all('.wargear-item .wargear-name')[2].textContent).toBe 'Krak grenades'
      done()

  it 'lists the right wargear options', () ->
    expect(@all('select.add-wargear option').length).toBe 17
    wargearText =  @get('select.add-wargear').textContent
    expect(wargearText).toContain 'Arc maul'
    expect(wargearText).toContain 'Phosphor blast pistol'
    expect(wargearText).not.toContain 'Hamburger'

  it 'cannot add a second leader', (done) ->
    @all('.available-fighter-card button')[0].click()
    Vue.nextTick () =>
      expect(@all('.chosen-fighter-card').length).toBe 1
      done()

  it 'can add a trooper', (done) ->
    @all('.available-fighter-card button')[1].click()
    Vue.nextTick () =>
      expect(@all('.chosen-fighter-card').length).toBe 2
      expect(@option(@all('select.add-wargear')[1], 'Radium carbine')).toBeGreaterThan -1
      done()

  it 'doesn\'t give the trooper the leader only weapons', () ->
    expect(@option(@all('select.add-wargear')[1], 'Phosphor blast pistol')).toBeUndefined()

  it 'only gives telescopic sight if you have a rifle first', (done) ->
    trooperWargear = @all('select.add-wargear')[1]
    expect(@option(trooperWargear, 'Telescopic sight')).toBeUndefined()
    @change trooperWargear, @option(trooperWargear, 'Galvanic rifle')
    Vue.nextTick () =>
      expect(@option(trooperWargear, 'Telescopic sight')).toBeGreaterThan -1
      done()

  it 'removes the telescopic sight from select if you remove the rifle', (done) ->
    expect(@all('.wargear-item button').length).toBe 2
    @all('.wargear-item button')[1].click()
    Vue.nextTick () =>
      expect(@option(@all('select.add-wargear')[1], 'Telescopic sight')).toBeUndefined()
      done()

  it 'can remove the trooper', (done) ->
    expect(@all('.chosen-fighter-card').length).toBe 2
    @all('.chosen-fighter-card .remove-button')[1].click()
    Vue.nextTick () =>
      expect(@all('.chosen-fighter-card').length).toBe 1
      done()

  it 'can exit cleanly and return to home', (done) ->
    @get('.action-btn').click()
    Vue.nextTick () =>
      @all('.modal-footer button')[0].click()
      Vue.nextTick () =>
        expect(@words('h2')).toBe 'Create a New Roster'
        done()
