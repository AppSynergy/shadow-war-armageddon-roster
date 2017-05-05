import Vue from 'vue'

describe 'the craftworlds roster', () ->

  it 'links to a faction roster', (done) ->
    @vm.$router.push 'build/craftworlds'
    Vue.nextTick () =>
      expect(@words('h2')).toBe 'Craftworld Eldar Kill Team'
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

  it 'can add a specialist', (done) ->
    @all('.available-fighter-card button')[3].click()
    Vue.nextTick () =>
      expect(@all('.chosen-fighter-card').length).toBe 3
      done()

  it 'leader has a wide variety of weapons', () ->
    wargearText =  @all('select.add-wargear')[0].textContent
    expect(wargearText).toContain 'Shimmershield'
    expect(wargearText).toContain 'Twin Avenger shuriken catapult'
    expect(wargearText).toContain 'Diresword'

  it 'which are not available to other fighters', () ->
    trooperWargearText =  @all('select.add-wargear')[1].textContent
    specialistWargearText =  @all('select.add-wargear')[2].textContent
    expect(trooperWargearText).not.toContain 'Shimmershield'
    expect(specialistWargearText).not.toContain 'Shimmershield'

  it 'specialist can take a heavy weapon', (done) ->
    specialistWargear =  @all('select.add-wargear')[2]
    expect(specialistWargear.textContent).toContain 'Heavy Weapons Platform with bright lance'
    @change specialistWargear, @option(specialistWargear, 'Heavy Weapons Platform with bright lance')
    Vue.nextTick () =>
      expect(@all('.wargear-item .wargear-name')[6].textContent).toBe 'Heavy Weapons Platform with bright lance'
      done()

  it 'a second specialist can\'t have a second heavy weapon', (done) ->
    @all('.available-fighter-card button')[3].click()
    Vue.nextTick () =>
      expect(@all('.chosen-fighter-card').length).toBe 4
      secondSpecialistWargearText =  @all('select.add-wargear')[3].textContent
      expect(secondSpecialistWargearText).not.toContain 'Heavy Weapons Platform with bright lance'
      done()

  it 'but he can if the first one remove his heavy weapon first', (done) ->
    @all('.wargear-item button')[0].click()
    Vue.nextTick () =>
      secondSpecialistWargearText =  @all('select.add-wargear')[3].textContent
      expect(secondSpecialistWargearText).toContain 'Heavy Weapons Platform with bright lance'
      done()

  it 'can exit cleanly and return to home', (done) ->
    @get('.action-btn').click()
    Vue.nextTick () =>
      @all('.modal-footer button')[0].click()
      Vue.nextTick () =>
        expect(@words('h2')).toBe 'Create a New Roster'
        done()
