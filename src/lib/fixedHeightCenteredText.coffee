class FixedHeightCenteredText extends Phaser.Text

  constructor: (game, x, y, @target_height, text, style={}) ->
    @existing_text = text
    @target_x = x
    @target_y = y
    super game, x, y, text, style
    @adjust()

  adjust: ->
    if @target_height > @height
      while @target_height > @height
        @fontSize += 1
    else
      while @target_height < @height
        @fontSize -= 1
    @y = @target_y

  update: ->
    if @existing_text != @text
      @existing_text = @text
      offset_x = @width/2.0
      @x = @target_x - offset_x if @x != @target_x - offset_x

module.exports = FixedHeightCenteredText

window.FixedHeightCenteredText = FixedHeightCenteredText
