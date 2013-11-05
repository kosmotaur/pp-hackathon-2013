define ['layoutmanager'], ->
  class AvatarView extends Backbone.Layout
    template  : 'views/avatar'
    el        : 'li'
    serialize : ->
      @model.toJSON()
    append    : (root, child) ->
      $(root).prepend child
