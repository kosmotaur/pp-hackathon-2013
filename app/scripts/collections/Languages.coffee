define ['app','models/Language', 'collections/SocketCollection'], (app, Language, SocketCollection) ->
  class Languages extends SocketCollection
    model : Language
    onSocketMessage : (e) ->
      @reset e.data unless e.data is "EMPTY"
