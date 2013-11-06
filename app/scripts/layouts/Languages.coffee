define ['nvd3','layoutmanager'], ->
  class LanguagesLayout extends Backbone.Layout
    template     : 'layouts/languages'
    initialize   : ->
      @listenTo @collection, 'reset', @refreshChart
      $(window).on 'resize', @refreshChart.bind(@)
    beforeRender : ->
      @chart = chart = nv.models.discreteBarChart().x((d) ->
        d.label
      ).y((d) ->
        d.value
      ).staggerLabels(true).tooltips(true).showValues(true).forceY([0, 100])
      @chart.height @calculateHeight()
      nv.addGraph ->
        chart
    afterRender : ->
      @refreshChart()
    calculateHeight : ->
      @$el.parent().height() - @$('h3').outerHeight()
    refreshChart : ->
      data = [
        key    : 'Language distribution'
        values : @collection.map (model) ->
          label : model.get 'language'
          value : (model.get 'prob') * 100
      ]
      d3.select(@$('svg')[0]).datum(data).transition().duration(200).call(@chart).attr('height', @calculateHeight())
