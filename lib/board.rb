
class Board
    # attr_accessor :grid

    def initialize
        @grid = {}
    end

    def create_coordinates
        (1..6).each do |height|
            (1..7).each do |column|
                @grid[height*10+column] = Hash.new
                @grid[height*10+column][:self] = '◯'
            end
        end
    end

    def punch
        display = ''
        (1..6).each do |height|
            display += "\n"
            (1..7).each do |column|
                display += " #{grid[height*10+column][:self]}"
            end
        end
        display += "\n\n"
    end

    def drop_the_disc(disc, column, coordinate = 10 + column)
        drop_the_disc(disc, column, coordinate + 10) unless grid[coordinate][:self] == '◯'
        grid[coordinate][:self] = disc
        coordinate
    end

    def space_available?(column)
        true if @grid[60+column][:self] == '◯'
    end 
end

board = Board.new
board.create_coordinates
print board.punch
# print board.grid