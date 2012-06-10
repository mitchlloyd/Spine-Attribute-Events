_ = require 'underscore'

ClassMethods =
  setAttributesSnapshot: (model) ->
    attrCopy = {}
    for k, v of model.attributes()
      attrCopy[k] = v

    @_attributesSnapshots[model.id] = attrCopy

  getAttributesSnapshot: (model) ->
    @_attributesSnapshots[model.id]

AttributeTracking =
  extended: ->
    @_attributesSnapshots = {}

    @bind 'refresh create', (models) =>
      # Spine is a little quirky with refresh({clear: true}) and passes false.
      # So we need this fix for now.
      models or= @all()

      # models could be an array of models or one model.
      if models.length?
        @setAttributesSnapshot(model) for model in models
      else
        @setAttributesSnapshot(models)

    @bind 'update', (model) =>
      for k, v of model.attributes()
        unless _.isEqual(@getAttributesSnapshot(model)[k], v)
          model.trigger("update:#{k}")
      @setAttributesSnapshot(model)

    @extend ClassMethods

Spine?.AttributeTracking = AttributeTracking
module?.exports = AttributeTracking