# frozen_string_literal: true
require 'pry-byebug'

require_relative 'instructions.rb'
require_relative 'player.rb'
require_relative 'computer.rb'
require_relative 'mesh.rb'

class Gameplay
  attr_reader :grid

  include Instructions

  def initialize(grid)
    @grid = grid
  end

  def horizontal_clearance?(last_move_coordinate, disc)
    count = 1
    count += go_in_direction(grid[last_move_coordinate][:left], disc, :left) if grid[last_move_coordinate][:left]
    count += go_in_direction(grid[last_move_coordinate][:right], disc, :right) if grid[last_move_coordinate][:right]
    true if count >= 4
  end

  def vertical_clearance?(last_move_coordinate, disc)
    count = 1
    count += go_in_direction(grid[last_move_coordinate][:bottom], disc, :bottom) if grid[last_move_coordinate][:bottom]
    true if count >= 4
  end

  def forward_slash_clearance?(last_move_coordinate, disc)
    count = 1
    count += go_in_direction(grid[last_move_coordinate][:top_right], disc, :top_right) if grid[last_move_coordinate][:top_right]
    count += go_in_direction(grid[last_move_coordinate][:bottom_left], disc, :bottom_left) if grid[last_move_coordinate][:bottom_left]
    true if count >= 4
  end

  def backward_slash_clearance?(last_move_coordinate, disc)
    count = 1
    count += go_in_direction(grid[last_move_coordinate][:top_left], disc, :top_left) if grid[last_move_coordinate][:top_left]
    count += go_in_direction(grid[last_move_coordinate][:bottom_right], disc, :bottom_right) if grid[last_move_coordinate][:bottom_right]
    true if count >= 4
  end

  def go_in_direction(coordinate, disc, direction, count = 0)
    grid[coordinate][:self] == disc ? count += 1 : (return count)
    grid[coordinate][direction] ? go_in_direction(grid[coordinate][direction], disc, direction, count) : (return count)
  end

  def toss(human,machine)
    arr = [human,machine]
    arr.shuffle
    toss_winner(arr[0].data)
    arr
  end

  def setup
    welcome_message
    board = Board.new
    mesh = Mesh.new(board)
    mesh.create
    board
  end

  def play(board)
    human = Player.new
    machine = Computer.new
    play_order = toss(human, machine)

    (1..21).each do |i|
      (0..1).each do |j|
        play_order[j].move
      end
    end
  end
end


# grid = {11=>{:self=>"◯"}, 12=>{:self=>"◯".colorize(:red)}, 13=>{:self=>"◯".colorize(:green)}, 14=>{:self=>"◯".colorize(:green)}, 15=>{:self=>"◯".colorize(:green)}, 16=>{:self=>"◯".colorize(:green)},17=>{:self=>"◯".colorize(:green)},
# 21=>{:self=>"◯"}, 22=>{:self=>"◯".colorize(:red)}, 23=>{:self=>"◯".colorize(:red)}, 24=>{:self=>"◯"}, 25=>{:self=>"◯"}, 26=>{:self=>"◯"}, 27=>{:self=>"◯"},
# 31=>{:self=>"◯"}, 32=>{:self=>"◯".colorize(:red)}, 33=>{:self=>"◯"}, 34=>{:self=>"◯".colorize(:red)}, 35=>{:self=>"◯"}, 36=>{:self=>"◯"}, 37=>{:self=>"◯"}, 
# 41=>{:self=>"◯"}, 42=>{:self=>"◯".colorize(:red)}, 43=>{:self=>"◯"}, 44=>{:self=>"◯"}, 45=>{:self=>"◯".colorize(:red)}, 46=>{:self=>"◯"}, 47=>{:self=>"◯"}, 
# 51=>{:self=>"◯"}, 52=>{:self=>"◯"}, 53=>{:self=>"◯"}, 54=>{:self=>"◯"}, 55=>{:self=>"◯"}, 56=>{:self=>"◯"}, 57=>{:self=>"◯"},
# 61=>{:self=>"◯"}, 62=>{:self=>"◯"}, 63=>{:self=>"◯"}, 64=>{:self=>"◯"}, 65=>{:self=>"◯"}, 66=>{:self=>"◯"}, 67=>{:self=>"◯"}}
# game =Gameplay.new(grid)
# mesh = Mesh.new(grid)
# mesh.create
# print grid

