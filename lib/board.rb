# require 'pry-byebug'
class Board
    attr_accessor :grid

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
        6.downto(1) do |height|
            display += "\n"
            1.upto(7) do |column|
                display += " #{grid[column+height*10][:self]}"
            end
        end
        display += "\n\n"
    end

    def drop_the_disc(disc, column, coordinate = 10 + column)
   
        if grid[coordinate][:self] == '◯'
            grid[coordinate][:self] = disc
            return coordinate.to_i
        else
            drop_the_disc(disc, column, coordinate + 10)
        end
    end

    def space_available?(column)
        true if @grid[60+column][:self] == '◯'
    end 

    def horizontal_clearance?(last_move_coordinate, disc)
        # binding.pry
        # puts grid
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

end

