# frozen_string_literal: true
require 'pry-byebug'

require_relative 'instructions.rb'

class Gameplay
  attr_reader :board, :win_checker

  include Instructions

  def initialize(board, win_checker)
    @board = board
    @win_checker = win_checker
    welcome_message
  end

  def toss(human,machine)
    players = [human,machine].shuffle
    toss_winner(players.first.data)
    puts players.first.data
    players
  end

  def win?(move,board,player)
    disc = player.data[:disc]
    username = player.data[:username]
    if win_checker.win?
      winning_message(username)
      true
    end
  end

  def play(human, machine)
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


