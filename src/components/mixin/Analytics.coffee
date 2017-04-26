Analytics =

  methods:

    track: (url) ->
      if window.ga && ga.create
        ga 'send', 'pageview', url

    event: (action, label) ->
      if window.ga && ga.create
        ga 'send', 'event', 'roster', action, label

export default Analytics
