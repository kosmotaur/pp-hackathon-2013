define ['layoutmanager', 'three'], ->
  class AppLayout extends Backbone.Layout
    tagName     : 'main'
    template    : 'layouts/appLayout'
    afterRender : ->
      @$el.appendTo 'body'
    initialize  : ->
      @render()
