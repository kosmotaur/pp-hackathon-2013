define ['layoutmanager'], ->
  class AvatarView extends Backbone.Layout
    template  : 'views/avatar'
    tagName   : 'li'
    serialize : ->
      data = @model.toJSON()
      data.hit = data.predicted_lang is data.lang
      data
    beforeRender : ->
      @$el.data cid : @model.cid
