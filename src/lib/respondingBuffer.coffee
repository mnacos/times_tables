class RespondingBuffer

  constructor: (@answer) ->
    @buffer = ''

  add: (char, right=null, wrong=null) ->
    @buffer = "#{@buffer}#{char}"
    if @answer == @buffer
      right() if right
    else
      wrong() if wrong && @buffer != @answer.substr 0, @buffer.length
    @buffer

module.exports = RespondingBuffer

window.RespondingBuffer = RespondingBuffer
