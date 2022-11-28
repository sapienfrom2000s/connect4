require_relative 'plays.rb'

class Computer
    attr_accessor :space

    include Plays

    def initialize
        @username = 'headlessMachine'
        @disc = disc
        @space = [1,2,3,4,5,6,7]
    end
#delete file from space, if it becomes full

    def disc
        puts "#{username} has been assigned #{'⬤'.colorize(:red)}"
        '⬤'.colorize(:red)
    end

    def move(board)
        sleep(1)
        input = @space.sample
        @space.delete(input) if board.space_available? != true
        puts input
        input
    end
end