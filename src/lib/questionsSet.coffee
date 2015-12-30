class Question

  constructor: (ask, expect) ->
    @ask = ask
    @expect = expect.toString()
    @good_answers = 0
    @bad_answers = 0

  question: -> @ask

  try: (user_answer, call_if_right=null, call_if_wrong=null) ->
    if @expect == user_answer.toString()
      @good_answers += 1
      if call_if_right && call_if_right instanceof Function
        call_if_right()
      else
        true
    else
      @bad_answers += 1
      if call_if_wrong && call_if_wrong instanceof Function
        call_if_wrong()
      else
        false

  answer: -> @expect

  good_hits: -> @good_answers

  bad_hits: -> @bad_answers

class RandomChooser

  pick: (questions) ->
    questions[Math.floor(Math.random()*questions.length)] if questions.length > 0

class QuestionsSet

  constructor: (@repeat=1, @chooser=new RandomChooser()) ->
    @objects = []

  populate: (q_list, a_list) ->
    @objects = (new Question(q_list[i], a_list[i]) for i in [0..q_list.length-1])

  all: -> @objects

  pending: ->
    (q for q in this.all() when q.good_hits() < @repeat)

  choose: ->
    return false unless @objects.length > 0
    @chooser.pick this.pending()

module.exports = QuestionsSet

window.Question = Question
window.RandomChooser = RandomChooser
window.QuestionsSet = QuestionsSet
