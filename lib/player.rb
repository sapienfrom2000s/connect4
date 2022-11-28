require_relative 'plays.rb'
require 'colorize'

class Player

    include Plays

    def initialize
        @username = username
        @disc = disc
    end

    def username 
        puts("Enter your username")
        gets.chomp
    end

    def disc
        puts "#{username} has been assigned #{'⬤'.colorize(:green)}"
        '⬤'.colorize(:green)
    end
    
    def move(board)
        loop do 
            puts('Enter a valid move')
            input = gets.chomp
            return input.to_i if input.match?(/^[1-7]$/) && board.space_available?(input.to_i)
            puts("You haven't read the instructions properly, scroll to the
                top to re-read it")
        end
    end
end