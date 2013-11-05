define [
  'app'
  'layouts/Languages'
  'layouts/Avatars'
  'layouts/Events'
  'layoutmanager'
], (app, LanguagesLayout, AvatarsLayout, EventsLayout) ->
  class AppLayout extends Backbone.Layout
    tagName      : 'main'
    className    : 'container-fluid'
    template     : 'layouts/appLayout'
    beforeRender : ->
      @setViews
        '.events'    : new EventsLayout collection : app.collections.events
        '.avatars'   : new AvatarsLayout collection : app.collections.avatars
        '.languages' : new LanguagesLayout collection : app.collections.languages
    afterRender  : ->
      @$el.appendTo 'body'
    initialize   : ->
      @render()
