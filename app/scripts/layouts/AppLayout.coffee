define ['layoutmanager'], ->
  class AppLayout extends Backbone.Layout
    tagName     : 'main'
    afterRender : ->
      @$el.appendTo 'body'
    initialize  : ->
      @render()
