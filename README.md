Spine Attribute Events
======================

#### Trigger events like "update:name" when attributes are updated.

Using
-----

Extend the module in your spine model.

    AttributeTracking = require 'spine_attr_events'

    class Document extends Spine.Model
      @configure "Document", "name", "description"
      @extend AttributeTracking

Then you can bind to 'update:name', and 'update:description' events.

    class DocumentController extends Spine.Controller
      constructor: ->
        super
        @model.bind 'update:name', -> alert 'name updated!'
        @model.bind 'update:description', -> alert 'description updated!'


Running the Tests
-----------------

1. Have mocha installed.
2. Run `mocha` in the root of this library.