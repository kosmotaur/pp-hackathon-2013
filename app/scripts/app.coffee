# container to attach shared components
define ['connect'], (connection) ->
  app = {}
  app.promise = connection
  connection.then (sockets) -> app.sockets = sockets
  app
