config = require './config.coffee'
InputPad = require './inputPad.coffee'

class State

  constructor: (game)->

  preload: ->
    @game.load.spritesheet 'keypad', 'assets/img/keypad.png', 96, 114, 27

  create: ->
    @game.stage.backgroundColor = '#ffff00'
    @inputPad = new InputPad(this, 100, 100)

  update: ->

module.exports = State
