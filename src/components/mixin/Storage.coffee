Storage =

  localStorage:
    rosters:
      type: Object
      default: {}

  methods:

    get: () ->
      @$localStorage.get 'rosters'

    set: (rosters) ->
      @$localStorage.set 'rosters', rosters

    findIndexByTeamName: (rosters, teamName) ->
      _.findIndex rosters, (x) => x.teamName == teamName

    saveRosterLocal: (data) ->
      rosters = @get()
      rosters[data.localKey] = data
      console.warn data.localKey, rosters
      @set rosters

    deleteRosterLocal: (data) ->
      rosters = @get()
      updateIndex = @findIndexByTeamName rosters, data.teamName
      rosters.splice updateIndex, 1
      @set rosters
      rosters

export default Storage
