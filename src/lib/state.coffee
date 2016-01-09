config = require './config.coffee'
InputPad = require './inputPad.coffee'
QuestionsSet = require './questionsSet.coffee'
RespondingBuffer = require './respondingBuffer.coffee'
FixedWidthText = require './fixedWidthText.coffee'
FixedHeightCenteredText = require './fixedHeightCenteredText.coffee'

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
    @inputPad = new InputPad(this, 100, 200)
    @inputPad.assignAll this.inputHandler

  inputHandler: (button) =>
    @answer_text.text = @buffer.add button.value(), =>
      @flashAndNext '#00ff00'
    , =>
      @flashAndNext '#ff0000'
    # FIXME: use Question #try to keep stats on number of failed attempts

  nextQuestion: ->
    @question_text.destroy() if @question_text
    @answer_text.destroy() if @answer_text
    @current_q = @questions.choose()
    @buffer = new RespondingBuffer(@current_q.answer())
    style = {font: '55px Arial', fill: '#222222', align: 'center'}
    @question_text = new FixedWidthText(@game, 164, 4, 140, @current_q.question(), style)
    @game.add.existing @question_text
    style = {font: '55px Arial', fill: '#222222', align: 'center'}
    @answer_text = new FixedHeightCenteredText(@game, 164+Math.ceil(@question_text.width/2.0), Math.ceil(@question_text.height*0.618), Math.ceil((@question_text.width+@question_text.height)*0.39*1.618), ' ', style)
    @game.add.existing @answer_text

  flashAndNext: (col) ->
    @game.stage.backgroundColor = col
    @game.time.events.add 500, =>
      @game.stage.backgroundColor = '#f0f0f0'
      @nextQuestion()

  update: ->

module.exports = State
