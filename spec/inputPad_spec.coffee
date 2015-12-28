class Phaser
class Phaser.Game
class HelperB
  add: ->
class HelperA
  constructor: ->
    @onInputDown = new HelperB()
class Phaser.Sprite
  constructor: ->
    @events = new HelperA()
class Phaser.Group
  create: ->
    new this.classType()

window.Phaser = Phaser

require '../src/lib/inputPad.coffee'

describe "InputPad", ->

  beforeEach ->
    @game = new Phaser.Game(800, 600)

  it "can be instantiated", ->
    spyOn(window, 'InputPad').and.stub()
    @pad = new InputPad(@game, 50, 50)
    expect(window.InputPad).toHaveBeenCalled()

  it "is an instance of Phaser.Group", ->
    @pad = new InputPad(@game, 50, 50)
    expect(@pad).toEqual(jasmine.any(Phaser.Group))

  it "creates a collection of 10 objects", ->
    @pad = new InputPad(@game, 50, 50)
    expect(@pad.keys().length).toBe 10

  it "contains InputPadKey instances", ->
    @pad = new InputPad(@game, 50, 50)
    expect(obj).toEqual(jasmine.any(InputPadKey)) for obj in @pad.keys()

  it "can #assignAll keys a callback", ->
    @pad = new InputPad(@game, 50, 50)
    spyOn(@pad, 'assign').and.stub()
    @pad.assignAll -> true
    expect(@pad.assign.calls.count()).toBe 10

describe "InputPadKey", ->

  beforeEach ->
    @game = new Phaser.Game(800, 600)

  it "is an instance of Phaser.Sprite", ->
    @key = new InputPadKey(@game, 50, 50, 1)
    expect(@key).toEqual jasmine.any(Phaser.Sprite)

  it "can return its own #value", ->
    @key = new InputPadKey(@game, 50, 50, 8)
    expect(@key.value()).toEqual 8

  it "can #assign onInputDown callback to itself", ->
    @key = new InputPadKey(@game, 50, 50, 1)
    spyOn(@key.events.onInputDown, 'add').and.stub()
    callback = -> true
    @key.assign callback
    expect(@key.events.onInputDown.add).toHaveBeenCalledWith callback

