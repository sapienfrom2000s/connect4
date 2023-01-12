require_relative './plays.rb'
require 'colorize'

class Player

    include Plays

    def initialize
        @username = input_name
        @disc = init_disc
        puts "#{@username} has been assigned #{'⬤'.colorize(:green)}"
    end

    def input_name 
        puts("Enter your username")
        gets.chomp
    end

    def init_disc
        '⬤'.colorize(:green)
    end

    def update_board(board, move, disc)
        board.update_move(move)
        board.update_disc(disc)
    end

    def move_input(board)
        loop do
            puts('Please enter a valid move')
            input = gets.chomp
            return input if input.match?(/^[1-7]$/) && board.space_available?(input.to_i)
            puts("#{@username}, you did something unacceptable. Think about it and try again")
        end

    end
    
    def move(board)
        input = move_input(board)
        update_board(board,input.to_i,'⬤'.colorize(:green))
        coordinate = board.drop_the_disc
    end
end