define ['associations'], ->
  class SocketCollection extends Backbone.Collection
    initialize : (models, options) ->
      socket = options.socket
      socket.onmessage = @onSocketMessage.bind @
      @on 'add', (model, collection) =>
        if @size() > 20
          @pop()
    onSocketMessage : (e) ->
      @add(JSON.parse(e.data), at : 0) unless e.data is "EMPTY"
