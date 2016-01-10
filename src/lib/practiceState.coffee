config = require './config.coffee'
InputPad = require './inputPad.coffee'
QuestionsSet = require './questionsSet.coffee'
RespondingBuffer = require './respondingBuffer.coffee'
FixedWidthText = require './fixedWidthText.coffee'
FixedHeightCenteredText = require './fixedHeightCenteredText.coffee'
SetChooser = require './setChooser.coffee'

class PracticeState

  constructor: (game) ->

  init: (@target_set)->
    @questions = new QuestionsSet()
    chooser = new SetChooser()
    data = chooser.data @target_set
    @questions.populate data[0], data[1] if data

  preload: ->
    @game.load.spritesheet 'keypad', 'assets/img/keypad.png', 96, 114, 27

  create: ->
    @nextQuestion()
    @game.stage.backgroundColor = '#f0f0f0'
    @inputPad = new InputPad(this, 100, 200)
    @inputPad.assignAll this.inputHandler

  inputHandler: (button) =>
    @answer_text.text = @buffer.add button.value(), =>
      @current_q.try @buffer.buffer
      @flashAndNext '#00ff00'
    , =>
      @current_q.try @buffer.buffer
      @flashAndNext '#ff0000'

  nextQuestion: ->
    @question_text.destroy() if @question_text
    @answer_text.destroy() if @answer_text
    @current_q = @questions.choose()
    window.current_q = @current_q
    if @current_q
      @buffer = new RespondingBuffer(@current_q.answer())
      style = {font: '55px Arial', fill: '#111111', align: 'center'}
      # FIXME: wrap @question_text and @answer_text in a display obj
      @question_text = new FixedWidthText(@game, 164, 4, 140, @current_q.question(), style)
      @game.add.existing @question_text
      style = {font: '55px Arial', fill: '#111111', align: 'center'}
      @answer_text = new FixedHeightCenteredText(@game, 164+Math.ceil(@question_text.width/2.0), Math.ceil(@question_text.height*0.618), Math.ceil((@question_text.width+@question_text.height)*0.39*1.618), ' ', style)
      @game.add.existing @answer_text
    else
      @game.state.start 'menu', true, false

  flashAndNext: (col) ->
    @game.stage.backgroundColor = col
    @game.time.events.add 500, =>
      @game.stage.backgroundColor = '#f0f0f0'
      @nextQuestion()

  update: ->

module.exports = PracticeState
