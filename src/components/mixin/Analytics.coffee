Analytics =

  methods:

    track: (url) ->
      if window.ga && ga.create
        ga 'send', 'pageview', url

export default Analytics
