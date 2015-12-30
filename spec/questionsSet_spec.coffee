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

