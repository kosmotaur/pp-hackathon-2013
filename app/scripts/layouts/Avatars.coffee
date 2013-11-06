define ['views/Avatar', 'layoutmanager'], (AvatarView) ->
  class AvatarsLayout extends Backbone.Layout
    template   : 'layouts/avatars'
    initialize : ->
      @listenTo @collection, 'add', (model) =>
        @addOne model
      @listenTo @collection, 'remove', (model) =>
        @removeOne model
    addOne    : (model) ->
      newView = new AvatarView model : model
      newView.render().done =>
        img = newView.$('img')
        img.load =>
          console.log(img[0].clientWidth)
          @$('ul').prepend newView.el

    removeOne : (model) ->
      oldView = @$('li').filter ->
        $(@).data('cid') is model.cid
      oldView.remove()
