require.config
  paths :
    jquery        : '../components/jquery/jquery'
    bootstrap     : '../components/sass-bootstrap/dist/js/bootstrap'
    backbone      : '../components/backbone/backbone'
    underscore    : '../components/underscore/underscore'
    layoutmanager : '../components/layoutmanager/backbone.layoutmanager'
    handlebars    : '../components/handlebars/handlebars'
    text          : '../components/requirejs-plugins/lib/text'
    json          : '../components/requirejs-plugins/src/json'
    associations  : '../components/backbone-associations/backbone-associations'
    three         : '../components/threejs/build/three'
    templates     : '../templates'
  shim  :
    bootstrap     : ['jquery']
    backbone      :
      deps    : ['underscore', 'jquery']
      exports : 'Backbone'
    associations  :
      deps : ['backbone']
    underscore    :
      exports : '_'
    layoutmanager :
      deps : ['backbone']
    handlebars    :
      exports : 'Handlebars'

require ['app', 'router', 'handlebars', 'layoutmanager', 'bootstrap'], (app, Router, Handlebars) ->
  app.router = new Router()

  app.templates = {}

  Backbone.Layout.configure
    manage : true
    prefix : 'templates/'
    fetch  : (path) ->
      path += '.hbs'
      return app.templates[path] if app.templates[path]?
      lmdone = @async()
      require ['text!' + path], (template) ->
        lmdone app.templates[path] = Handlebars.compile template

  # Trigger the initial route and enable HTML5 History API support, set the
  # root folder to '/' by default.  Change in app.js.
  # First get the config file
  Backbone.history.start root : app.root

  # All navigation that is relative should be passed through the navigate
  # method, to be processed by the router. If the link has a `data-bypass`
  # attribute, bypass the delegation completely.
  $(document).on "click", "a[href]:not([data-bypass])", (evt) ->

    # Get the absolute anchor href.
    href =
      prop : $(this).prop("href")
      attr : $(this).attr("href")

    # Get the absolute root.
    root = location.protocol + "//" + location.host + app.root

    # Ensure the root is part of the anchor href, meaning it's relative.
    if href.prop.slice(0, root.length) is root

      # Stop the default event to ensure the link will not cause a page
      # refresh.
      evt.preventDefault()

      # `Backbone.history.navigate` is sufficient for all Routers and will
      # trigger the correct events. The Router's internal `navigate` method
      # calls this anyways.  The fragment is sliced from the root.
      Backbone.history.navigate href.attr, true
