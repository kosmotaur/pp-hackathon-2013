define ['views/Event', 'layoutmanager'], (EventView) ->
  class EventsLayout extends Backbone.Layout
    template     : 'layouts/events'
    beforeRender : ->
      @collection.each (eventModel) =>
        @insertView 'ul', new EventView model : eventModel
    afterRender  : ->
      @listenTo @collection, 'add', =>
        newView = new EventView
          model : @collection.at 0
        @insertView newView

