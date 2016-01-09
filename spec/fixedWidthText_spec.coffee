class Phaser
class Phaser.Game
class Phaser.Text

window.Phaser = Phaser

require '../src/lib/fixedWidthText.coffee'

describe "FixedWidthText", ->

  it "can be instantiated", ->
    spyOn(window, 'FixedWidthText').and.stub()
    @text = new FixedWidthText(160)
    expect(window.FixedWidthText).toHaveBeenCalled()

