import Vue from 'vue'

describe 'the sisters of battle roster', () ->

  it 'links to a faction roster', (done) ->
    @vm.$router.push 'build/adepta_sororitas'
    Vue.nextTick () =>
      expect(@words('h2')).toBe 'Adepta Sororitas Kill Team'
      done()

  it 'can add a sister with a bolter', (done) ->
    @all('.available-fighter-card button')[1].click()
    Vue.nextTick () =>
      expect(@all('.chosen-fighter-card').length).toBe 1
      wargear = @get('select.add-wargear')
      @change wargear, @option(wargear, 'Boltgun')
      Vue.nextTick () =>
        expect(@all('.wargear-item .wargear-name')[2].textContent).toBe 'Boltgun'
        done()

  it 'can duplicate the sister', (done) ->
    @get('.duplicate-button').click()
    Vue.nextTick () =>
      expect(@all('.chosen-fighter-card').length).toBe 2
      expect(@all('.fighter-cost')[0].textContent).toBe '125 points'
      expect(@all('.fighter-cost')[1].textContent).toBe '125 points'
      expect(@all('.wargear-item').length).toBe 6
      done()

  it 'can remove the bolter from the clone, but not the original', (done) ->
    @all('.wargear-item button')[1].click()
    Vue.nextTick () =>
      expect(@all('.fighter-cost')[0].textContent).toBe '125 points'
      expect(@all('.fighter-cost')[1].textContent).toBe '90 points'
      expect(@all('.wargear-item .wargear-name')[2].textContent).toBe 'Boltgun'
      expect(@all('.wargear-item').length).toBe 5
      done()

  it 'can delete the cloned sister, remove the bolter from the original, and end up back at the right points', (done) ->
    @all('.chosen-fighter-card .remove-button')[1].click()
    Vue.nextTick () =>
      expect(@all('.chosen-fighter-card').length).toBe 1
      @all('.wargear-item button')[0].click()
      Vue.nextTick () =>
        expect(@get('.fighter-cost').textContent).toBe '90 points'
        done()

  it 'can exit cleanly and return to home', (done) ->
    @get('.action-btn').click()
    Vue.nextTick () =>
      @all('.modal-footer button')[0].click()
      Vue.nextTick () =>
        expect(@words('h2')).toBe 'Create a New Roster'
        done()
