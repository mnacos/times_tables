config = require './config.coffee'
InputPad = require './inputPad.coffee'
QuestionsSet = require './questionsSet.coffee'
RespondingBuffer = require './respondingBuffer.coffee'

class State

  constructor: (game)->

  preload: ->
    @game.load.spritesheet 'keypad', 'assets/img/keypad.png', 96, 114, 27

  create: ->
    @questions = new QuestionsSet()
    @questions.populate(['6x8', '7x8', '8x8'], ['48', '56', '64'])
    @nextQuestion()
    @game.stage.backgroundColor = '#f0f0f0'
    @inputPad = new InputPad(this, 100, 100)
    @inputPad.assignAll this.inputHandler

  inputHandler: (button) =>
    @buffer.add button.value(), =>
      @nextQuestion()
    , =>
      @nextQuestion()
    # FIXME: use Question #try to keep stats on number of failed attempts

  nextQuestion: ->
    @question_text.destroy() if @question_text
    @current_q = @questions.choose()
    @buffer = new RespondingBuffer(@current_q.answer())
    style = {font: '65px Arial', fill: '#ff0044', align: 'center'}
    @question_text = @game.add.text @game.world.centerX, @game.world.centerY, @current_q.question(), style

  update: ->

module.exports = State
