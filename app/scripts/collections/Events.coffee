define ['app','models/Event', 'collections/SocketCollection'], (app, Event, SocketCollection) ->
  class Languages extends SocketCollection
    model : Event
