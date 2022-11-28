require_relative 'gameplay.rb'

game = Gameplay.new
board = game.setup
game.play(board)