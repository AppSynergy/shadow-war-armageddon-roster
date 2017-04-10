Storage =

  localStorage:
    rosters:
      type: Array
      default: []

  methods:

    get: () ->
      @$localStorage.get 'rosters'

    set: (rosters) ->
      @$localStorage.set 'rosters', rosters

    findIndexByTeamName: (rosters, teamName) ->
      _.findIndex rosters, (x) => x.teamName == teamName

    saveRosterLocal: (data) ->
      rosters = @get()
      data.totalPointsCost = @$store.getters.getTotalPointsCost
      updateIndex = @findIndexByTeamName rosters, data.teamName
      if updateIndex >= 0
        rosters[updateIndex] = data
      else
        rosters.push data
      @set rosters

    deleteRosterLocal: (data) ->
      rosters = @get()
      updateIndex = @findIndexByTeamName rosters, data.teamName
      rosters.splice updateIndex, 1
      @set rosters
      rosters

export default Storage
