State = require './lib/state.coffee'
config = require './lib/config.coffee'

document.addEventListener "DOMContentLoaded", (event) ->
  demo = new Phaser.Game config.width, config.height, Phaser.AUTO
  demo.state.add 'game', State, yes
