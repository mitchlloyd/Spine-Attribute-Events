ClassMethods =
  setOldAttributes: (model) ->
    attrCopy = {}
    for k, v of model.attributes()
      attrCopy[k] = v

    @oldAttributes[model.id] = attrCopy

  getOldAttributes: (model) ->
    @oldAttributes[model.id]

AttributeTracking =
  extended: ->
    @oldAttributes = {}

    @bind 'refresh create', (models) =>
      # models could be an array of models or one model.
      if models.length?
        @setOldAttributes(model) for model in models
      else
        @setOldAttributes(models)

    @bind 'update', (model) =>
      for k, v of model.attributes() when @getOldAttributes(model)[k] isnt v
        model.trigger("update:#{k}")
      @setOldAttributes(model)

    @extend ClassMethods

Spine.AttributeTracking = AttributeTracking
module?.exports = AttributeTracking