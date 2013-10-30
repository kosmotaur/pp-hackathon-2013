define [
  'backbone'
], ->
  class AppRouter extends Backbone.Router
    routes :
      '' : 'index'
    index  : ->
      # building initial view goes here
