define ['layoutmanager'], ->
  class EventView extends Backbone.Layout
    template  : 'views/event'
    el        : 'li'
    serialize : ->
      @model.toJSON()
    append    : (root, child) ->
      $(root).prepend child
