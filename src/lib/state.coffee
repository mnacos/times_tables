config = require './config.coffee'
InputPad = require './inputPad.coffee'
QuestionsSet = require './questionsSet.coffee'
RespondingBuffer = require './respondingBuffer.coffee'

class State

  constructor: (game)->

  preload: ->
    @game.load.spritesheet 'keypad', 'assets/img/keypad.png', 96, 114, 27

  create: ->
    window.questions = new QuestionsSet()
    window.questions.populate(['6x8', '7x8', '8x8'], ['48', '56', '64'])
    @nextQuestion()
    @game.stage.backgroundColor = '#f0f0f0'
    @inputPad = new InputPad(this, 100, 100)
    @inputPad.assignAll this.inputHandler

  inputHandler: (button) =>
    window.buffer.add button.value(), =>
      @nextQuestion()
    , =>
      @nextQuestion()
    # FIXME: use Question #try to keep stats on number of failed attempts

  nextQuestion: ->
    @eraseQuestion()
    window.current_question = window.questions.choose()
    window.buffer = new RespondingBuffer(window.current_question.answer())
    style = {font: '65px Arial', fill: '#ff0044', align: 'center'}
    @game.add.text @game.world.centerX, @game.world.centerY, window.current_question.question(), style

  eraseQuestion: ->
    # FIXME: doesn't work
    graphics = @game.add.graphics 500, 500
    graphics.beginFill '#ff0000'
    graphics.drawRect 0, 0, 1300, 1300
    graphics.endFill

  update: ->

module.exports = State
