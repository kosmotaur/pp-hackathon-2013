define ['associations'], ->
  class SocketCollection extends Backbone.Collection
    initialize : (options) ->
      @socket = options.socket
      @socket.onmessage = @onSocketMessage.bind @

    onSocketMessage : (e) ->
      @add e.data unless e.data is "EMPTY"
      if @size() > 30
        @shift()
