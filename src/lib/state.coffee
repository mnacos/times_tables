config = require './config.coffee'
InputPad = require './inputPad.coffee'

class State

  constructor: (game)->

  preload: ->
    @game.load.spritesheet 'keypad', 'assets/img/keypad.png', 96, 114, 27

  create: ->
    @game.stage.backgroundColor = '#f0f0f0'
    @inputPad = new InputPad(this, 100, 100)
    @inputPad.assignAll (button) -> console.log button.value()

  update: ->

module.exports = State
