Collections =

  methods:

    mapKeys: (collection) ->
      _.mapObject collection, (x, key) ->
        x.key = key
        x

    mapRoles: (collection) ->
      _.map collection, (x, role) ->
        _.map x, (y) ->
          y.role = role
          y
        x

    matchValues: (collection, property ) ->
      _.intersection(property.values, _.pluck(collection, property.matches))

    matchValuesIsEmpty: (collection, property) ->
      _.isEmpty @matchValues(collection, property)

export default Collections
