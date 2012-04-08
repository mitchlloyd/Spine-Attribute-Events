should = require 'should'
sinon = require 'sinon'
Spine = require './lib/spine'

AttributeTracking = require '../spine_attr_events'

describe 'Firing update events', ->
  Puppy = undefined
  spy = undefined

  beforeEach ->
    Puppy = Spine.Model.setup("Puppy", ["name"])
    Puppy.extend AttributeTracking
    spy = sinon.spy()

  it 'fires an update:name event when name is updated', ->
    gus = Puppy.create(name: 'gus')
    gus.bind 'update:name', spy
    gus.updateAttribute('name', 'henry')
    spy.called.should.be.true

  it "doesn't fire an update:name event if the new name isn't different", ->
    gus = Puppy.create(name: 'gus')
    gus.bind 'update:name', spy
    gus.updateAttribute('name', 'gus')
    spy.called.should.be.false

  it "works with refreshed models", ->
    Puppy.refresh({name: 'gus', id: 1})
    gus = Puppy.find(1)
    gus.bind 'update:name', spy
    gus.updateAttribute('name', 'jake')
    spy.called.should.be.true