class FixedWidthText extends Phaser.Text

  constructor: (game, x, y, @target_width, text, style={}) ->
    super game, x, y, text, style
    @adjust()

  adjust: ->
    if @target_width > @width
      while @target_width > @width
        @fontSize += 1
    else
      while @target_width < @width
        @fontSize -= 1

module.exports = FixedWidthText

window.FixedWidthText = FixedWidthText
