require 'pry-byebug'
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

    def drop_the_disc
        grid[@coordinate][:self] = @disc 
    end

    def space_available?(column)
        true if @grid[60+column][:self] == '◯'
    end 

    def update_move(move)
        @coordinate = move + 10
        update_move(@coordinate) unless grid[@coordinate][:self] == '◯'
    end

    def update_disc(disc)
        @disc = disc
    end

    def horizontal_clearance?
        count = 1
        left = -1
        right = 1
        count += count_in_direction(left) 
        count += count_in_direction(right) 
        count >= 4
    end
    
    def vertical_clearance?
        count = 1
        down = -10
        count += count_in_direction(down)  
        count >= 4
    end
    
    def forward_slash_clearance?
        count = 1
        right_top = 11
        left_down = -11
        count += count_in_direction(right_top) 
        count += count_in_direction(left_down) 
        count >= 4
    end
    
    def backward_slash_clearance?
        count = 1
        left_top = -9
        right_down = 9
        count += count_in_direction(left_top) 
        count += count_in_direction(right_down) 
        count >= 4
    end
    
    def count_in_direction(movement, count = 0)
        amplified_movement = movement*(count+1)
        coordinate = @coordinate + amplified_movement
        return count unless grid[coordinate] 
        return count unless grid[coordinate][:self] == @disc 
        count += 1
        count_in_direction(movement, count)
    end
end

