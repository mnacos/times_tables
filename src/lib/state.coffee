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
    @questions.populate(
      [
         '1x6',  '2x6',  '3x6',
         '4x6',  '5x6',  '6x6',
         '7x6',  '8x6',  '9x6',
        '10x6', '11x6', '12x6'
      ],
      [
           '6',   '12',   '18',
          '24',   '30',   '36',
          '42',   '48',   '54',
          '60',   '66',   '72'
      ]
    )
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
    style = {font: '72px Arial', fill: '#000000', align: 'center'}
    @question_text = @game.add.text 108, 10, "#{@current_q.question()} ?", style

  update: ->

module.exports = State
