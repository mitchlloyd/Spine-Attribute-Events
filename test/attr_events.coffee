should = require 'should'
sinon = require 'sinon'
Spine = require './lib/spine'

AttributeTracking = require '../spine_attr_events'

describe 'Firing update events', ->
  Puppy = undefined
  gus = undefined
  spy = undefined

  beforeEach ->
    Puppy = Spine.Model.setup("Puppy", ["name"])
    Puppy.extend AttributeTracking
    gus = Puppy.create(name: 'gus')
    spy = sinon.spy()

  it 'fires an update:name event when name is updated', ->
    gus.bind 'update:name', spy
    gus.updateAttribute('name', 'henry')
    spy.called.should.be.true

  it "doesn't fire an update:name event if the new name isn't different", ->
    gus.bind 'update:name', spy
    gus.updateAttribute('name', 'gus')
    spy.called.should.be.false