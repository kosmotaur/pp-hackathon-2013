define [
  'app'
  'layoutmanager'
  'layouts/Languages'
  'layouts/Avatars'
  'layouts/Events'
], (app) ->
  class AppLayout extends Backbone.Layout
    tagName     : 'main'
    className   : 'container-fluid'
    template    : 'layouts/appLayout'
    afterRender : ->
      @$el.appendTo 'body'
    initialize  : ->
      @render()
