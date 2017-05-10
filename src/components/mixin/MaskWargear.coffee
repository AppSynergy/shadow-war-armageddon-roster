MaskWargear =

  methods:
    maskWargearItems: (weapons, wargear) ->
      maskers = _.filter weapons, (x) -> _.has x, 'masks'
        .map (x) -> x.masks
      _.reject wargear, (x) ->
        _.contains _.flatten(maskers), x.key

export default MaskWargear
