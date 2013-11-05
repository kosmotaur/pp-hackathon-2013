define [
  'app'
  'layouts/AppLayout'
  'backbone'
], (
  app,
  AppLayout
) ->
  class AppRouter extends Backbone.Router
    routes :
      '' : 'index'
    index  : ->
      app.promise.then ->
        new AppLayout
