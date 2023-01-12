require_relative './plays.rb'
require 'colorize'

class Computer
    attr_accessor :space

    include Plays

    def initialize
        @username = 'headlessMachine'
        @disc = init_disc
        @space = [1,2,3,4,5,6,7]
        puts "#{@username} has been assigned #{@disc}"
    end

    def init_disc
        '⬤'.colorize(:red)
    end

    def update_board(board, move, disc)
        board.update_move(move)
        board.update_disc(disc)
    end

    def get_input(board)
       input = @space.sample
       if board.space_available?(input)
        return input
       else
        @space.delete(input) 
        get_input(board)
       end
    end

    def move(board)
        sleep(1)
        input = get_input(board)
        update_board(board, input, @disc)
        coordinate = board.drop_the_disc 
        puts "#{@username} inserted its disc on #{input} file" 
        coordinate
    end
end