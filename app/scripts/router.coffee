define [
  'layouts/AppLayout'
  'backbone'
], (AppLayout) ->
  class AppRouter extends Backbone.Router
    routes :
      '' : 'index'
    index  : ->
      new AppLayout()
