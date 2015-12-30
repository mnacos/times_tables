class Question

  constructor: (ask, expect) ->
    @ask = ask
    @expect = expect.toString()

  question: -> @ask

  try: (user_answer, call_if_right=null, call_if_wrong=null) ->
    if @expect == user_answer.toString()
      if call_if_right && call_if_right instanceof Function
        call_if_right()
      else
        true
    else
      if call_if_wrong && call_if_wrong instanceof Function
        call_if_wrong()
      else
        false

  answer: -> @expect

class QuestionsSet

  constructor: ->
    @objects = []

  populate: (q_list, a_list) ->
    @objects = (new Question(q_list[i], a_list[i]) for i in [0..q_list.length-1])

  all: -> @objects

module.exports = QuestionsSet

window.Question = Question
window.QuestionsSet = QuestionsSet
