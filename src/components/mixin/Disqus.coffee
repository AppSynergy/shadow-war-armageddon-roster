
Disqus =

  computed:
    disqusConfig: () -> () ->
      @page.url = "http://killteams.com"
      @page.identifier = "/"

  methods:

    disqusSetup: () ->
      disqus_config = @disqusConfig
      (() ->
        script = document.createElement 'script'
        script.src = 'https://killteams-com.disqus.com/embed.js'
        script.setAttribute 'data-timestamp', +new Date()
        (document.head || document.body).appendChild script
      )()

    disqusReset: () ->
      if DISQUS? then DISQUS.reset
        reload: true
        config: @disqusConfig

export default Disqus
