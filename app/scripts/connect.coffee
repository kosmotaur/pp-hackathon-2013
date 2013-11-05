define ['jquery'], ->
  sockets = {}
  rootUrl = 'ws://ec2-54-216-111-186.eu-west-1.compute.amazonaws.com:8000'
  connectDeferred = $.Deferred()
  $.when(['types', 'avatars', 'langs'].map (endpointName) ->
    d = $.Deferred()
    sockets[endpointName] = new WebSocket rootUrl + '/' + endpointName
    sockets[endpointName].onopen = ->
      d.resolve()
    d
  ).then ->
    connectDeferred.resolve sockets
  connectDeferred.promise()
