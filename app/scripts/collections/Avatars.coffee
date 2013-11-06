define ['app','models/Avatar', 'collections/SocketCollection'], (app, Avatar, SocketCollection) ->
  class Languages extends SocketCollection
    model : Avatar

