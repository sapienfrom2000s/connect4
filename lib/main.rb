require_relative 'gameplay.rb'
require_relative 'board.rb'
require_relative 'win_checker.rb'
require_relative 'player.rb'
require_relative 'computer.rb'

board = Board.new
win_checker = Win_Checker.new(board)
game = Gameplay.new(board, win_checker)
game.play(Player.new, Computer.new)