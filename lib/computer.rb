require_relative './plays.rb'
require 'colorize'

class Computer
    attr_accessor :space

    include Plays

    def initialize
        @username = 'headlessMachine'
        @disc = init_disc
        @space = [1,2,3,4,5,6,7]
        puts "#{@username} has been assigned #{'⬤'.colorize(:red)}"
    end

    def init_disc
        '⬤'.colorize(:red)
    end

    def move(board)
        sleep(1)
        input = @space.sample
        coordinate = board.drop_the_disc('⬤'.colorize(:red), input)
        @space.delete(input) if board.space_available?(input) != true
        puts "#{@username} inserted its disc on #{input} file" 
        coordinate
    end
end