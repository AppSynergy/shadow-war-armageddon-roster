Collections =

  methods:

    mapKeys: (collection) ->
      _.map collection, (x, key) ->
        x.key = key
        x

    mapRoles: (collection) ->
      _.map collection, (x, role) ->
        _.map x, (y) ->
          y.role = role
          y
        x

export default Collections
