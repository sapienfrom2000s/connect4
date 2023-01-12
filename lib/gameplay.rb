# frozen_string_literal: true
require 'pry-byebug'

require_relative './instructions.rb'
require_relative './player.rb'
require_relative './computer.rb'
require_relative './board.rb'

class Gameplay
  attr_reader :board

  include Instructions

  def toss(human,machine)
    arr = [human,machine]
    rand(1..8).times{ arr.shuffle! }
    toss_winner(arr[0].data)
    arr
  end

  def setup
    welcome_message
    board = Board.new
    board.create_coordinates
    board
  end

  def win?(move,board,player)
    disc = player.data[:disc]
    username = player.data[:username]
    if board.winning_combination?
      winning_message(username)
      true
    end
  end

  def play(board)
    human = Player.new
    machine = Computer.new
    play_order = toss(human, machine)
    print board.punch

    (1..21).each do |i|
      (0..1).each do |j|
        move = play_order[j].move(board)
        print board.punch
        exit if win?(move,board,play_order[j]) == true
      end
      draw_message if i==21
    end
  end
end


