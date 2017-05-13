TeamSummary =

  computed:

    totalPointsCost: () -> @$store.getters.getTotalPointsCost

    totalNumberFighters: () -> @$store.getters.getTotalNumberFighters

    dirty: () ->
      if @totalNumberFighters > 0
        @$store.getters.getDirty
      else false

    empty: () -> @totalNumberFighters == 0

export default TeamSummary
