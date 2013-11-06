define ['app','models/Event', 'collections/SocketCollection'], (app, Event, SocketCollection) ->
  class Languages extends SocketCollection
    model : Event
    onSocketMessage : (e) ->
      @reset JSON.parse(e.data) unless e.data is "EMPTY"
