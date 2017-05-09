TrueCost =

  computed:

    totalPointsCost: () ->
      fighterCosts = _.map @chosenFighters, (x,i) =>
        @$store.getters.getFighterCost(i, @trueCost(x))
      _.reduce fighterCosts, ((xs, x) -> xs + x), 0

  methods:
    trueCost: (fighter) ->
      f = _.find @faction.fighters, (x) -> x.name == fighter.name
      console.warn "fighters", @faction, f
      f.cost

export default TrueCost
