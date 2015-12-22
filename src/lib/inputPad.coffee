class InputPadKey extends Phaser.Sprite

  constructor: (game, x, y, number, pressed) ->
    target = if pressed
      if number == 0
        24
      else
        number + 8
    else
      if number == 0
        21
      else
        number - 1
    super game, x, y, 'keypad', target

  assign: (callback) ->
    this.inputEnabled = true
    this.events.onInputDown.add callback

class InputPad extends Phaser.Group

  constructor: (game, @offset_x, @offset_y) ->
    Phaser.Group.call this, game
    this.classType = InputPadKey
    @collection = new Array(10)
    this.createKeys()

  createKeys: ->
    col = 0
    row = 0
    for i in [1..9]
      @collection[i] = this.create(@offset_x + col*88, @offset_y + row*88, i, false)
      if (i % 3) == 0
        col = 0
        row = i // 3
      else
        col += 1
    @collection[0] = this.create(@offset_x + 1*88, @offset_y + 3*88, 0, false)

  keys: ->
    (@collection[i] for i in [0..9])

  assign: (i, callback) ->
    @collection[i].assign callback

  assignAll: (callback) ->
    this.assign(i, callback) for i in [0..9]

module.exports = InputPad

window.InputPadKey = InputPadKey
window.InputPad = InputPad
