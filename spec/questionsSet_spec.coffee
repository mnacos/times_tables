class PickFirst
  pick: (questions) -> questions[0]

window.PickFirst = PickFirst

require '../src/lib/questionsSet.coffee'

describe "QuestionsSet", ->

  it "can be instantiated", ->
    spyOn(window, 'QuestionsSet').and.stub()
    @questions = new QuestionsSet()
    expect(window.QuestionsSet).toHaveBeenCalled()

  it "supports #populate with [questions] and [answers]", ->
    @questions = new QuestionsSet()
    @questions.populate(['6x8', '7x8', '8x8'], ['48', '56', '64'])
    expect(@questions.all().length).toEqual 3

  it "accepts a @repeat constructor argument", ->
    @questions = new QuestionsSet(3)
    expect(@questions.repeat).toEqual 3

  it "#pending returns questions with good_hits() < @repeat", ->
    @questions = new QuestionsSet(2)
    @questions.populate(['6x8', '7x8', '8x8'], ['48', '56', '64'])
    @questions.all()[0].try '48' for i in [0..1]
    @questions.all()[1].try '56'
    expect(@questions.pending().length).toEqual 2

  it "can #choose a question when some are available", ->
    @questions = new QuestionsSet()
    @questions.populate(['8x8'], ['64'])
    expect(@questions.choose().question()).toEqual '8x8'

  it "accepts a @chooser strategy in its constructor", ->
    @questions = new QuestionsSet(3, new PickFirst())
    @questions.populate(['6x8', '7x8', '8x8'], ['48', '56', '64'])
    expect(@questions.choose().question()).toEqual '6x8'

  it "cannot #choose a question when there are none", ->
    @questions = new QuestionsSet()
    expect(@questions.choose()).toEqual false

  it "cannot #choose a question when they have all been answered", ->
    @questions = new QuestionsSet()
    @questions.populate(['8x8'], ['64'])
    @questions.all()[0].try '64'
    expect(@questions.choose()).not.toBeTruthy()

describe "RandomChooser", ->

  it "can #pick a question from a list using Math.random", ->
    spyOn(Math, 'random').and.returnValue(0.7)
    @chooser = new RandomChooser()
    chosen = @chooser.pick [new Question('7x8', '56'), new Question('8x8', '64')]
    expect(Math.random).toHaveBeenCalled()
    expect(chosen.question()).toEqual '8x8'

describe "Question", ->

  beforeEach ->
    @question = new Question('8x8', '64')

  it "knows its #question", ->
    expect(@question.question()).toEqual '8x8'

  it "knows the expected #answer", ->
    expect(@question.answer()).toEqual '64'

  it "calls a function if a #try is right", ->
    @call_if_right = ->
    spyOn(this, 'call_if_right').and.stub()
    @question.try '64', @call_if_right
    expect(@call_if_right).toHaveBeenCalled()

  it "calls a function if a #try is wrong", ->
    @call_if_right = ->
    @call_if_wrong = ->
    spyOn(this, 'call_if_wrong').and.stub()
    @question.try '56', @call_if_right, @call_if_wrong
    expect(@call_if_wrong).toHaveBeenCalled()

  it "returns true/false if a #try has no callbacks", ->
    expect(@question.try '56').toEqual false
    expect(@question.try '64').toEqual true

  it "counts the right answers", ->
    @question.try '64' for i in [0..2]
    expect(@question.good_hits()).toEqual 3

  it "counts the wrong answers", ->
    @question.try '56' for i in [0..2]
    expect(@question.bad_hits()).toEqual 3

