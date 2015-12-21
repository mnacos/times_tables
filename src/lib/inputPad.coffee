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

class InputPad extends Phaser.Group

  constructor: (game, @offset_x, @offset_y) ->
    Phaser.Group.call this, game
    this.classType = InputPadKey
    @key = []
    this.createKeys()

  createKeys: ->
    col = 0
    row = 0
    for i in [1..9]
      pressed = i == 100
      @key.push this.create @offset_x + col*87, @offset_y + row*88, i, pressed
      if (i % 3) == 0
        col = 0
        row = i // 3
      else
        col += 1
    @key.push this.create @offset_x, @offset_y + 3*88, 0, false

module.exports = InputPad

window.InputPadKey = InputPadKey
window.InputPad = InputPad
