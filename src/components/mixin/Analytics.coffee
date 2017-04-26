Analytics =

  methods:

    track: (url) ->

      if window.ga && window.ga.create
        ga 'send', 'pageview', url
        console.warn "track ", url
      else
        console.warn "no tracking"

    event: (action, label) ->
      if window.ga && window.ga.create
        ga 'send', 'event', 'roster', action, label
        console.warn "event", action, label
      else
        console.warn "no tracking"

export default Analytics
