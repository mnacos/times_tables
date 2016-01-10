config = require './config.coffee'
QuestionsSet = require './questionsSet.coffee'
FixedWidthText = require './fixedWidthText.coffee'
FixedHeightCenteredText = require './fixedHeightCenteredText.coffee'

class MenuState

  constructor: (game)->

  init: ->
    @options = []

  preload: ->

  create: ->
    @game.stage.backgroundColor = '#f0f0f0'
    @add_set('... x 2', '2times')
    @add_set('... x 3', '3times')
    @add_set('... x 4', '4times')
    @add_set('... x 5', '5times')
    @add_set('... x 6', '6times')
    @add_set('... x 7', '7times')
    @add_set('... x 8', '8times')
    @add_set('... x 9', '9times')
    @game.add.existing option for option in @options

  add_set: (label, token) ->
    style = {font: '55px Arial', fill: '#111111', align: 'center'}
    new_text = new FixedHeightCenteredText(@game, 168, 4+(@options.length)*65, 65, label, style)
    @options.push new_text
    new_text.inputEnabled = true
    new_text.events.onInputDown.add =>
      @game.state.start 'practice', true, false, token

module.exports = MenuState
