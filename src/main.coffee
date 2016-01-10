PracticeState = require './lib/practiceState.coffee'
MenuState = require './lib/menuState.coffee'
config = require './lib/config.coffee'

document.addEventListener "DOMContentLoaded", (event) ->
  game = new Phaser.Game config.width, config.height, Phaser.AUTO
  game.state.add 'menu', MenuState, yes
  game.state.add 'practice', PracticeState, yes
  game.state.start 'menu'
