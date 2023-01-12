require 'pry-byebug'
class Board
    attr_reader :grid
    SELF_COUNT = 1

    def initialize
        @grid = {}
    end

    def create_coordinates
        (6).downto(1) do |height|
            (1).upto(7) do |column|
                coordinate = column+height*10
                @grid[coordinate] = '◯'
            end
        end
    end

    def punch
        display = ''
        grid.each_key do |coordinate|
            display += grid[coordinate] + ' '
            display += "\n" if coordinate%10 == 7
        end
        display += "\n\n"
    end

    def drop_the_disc
        grid[@coordinate] = @disc 
    end

    def space_available?(column)
        true if grid[60+column] == '◯'
    end 

    def update_move(move)
        @coordinate = move + 10
        update_move(@coordinate) unless grid[@coordinate] == '◯'
    end

    def update_disc(disc)
        @disc = disc
    end
    
    def count_in_direction(movement, count = 0)
        amplified_movement = movement*(count+1)
        coordinate_relative = @coordinate + amplified_movement
        return count unless grid[coordinate_relative] 
        return count unless grid[coordinate_relative] == @disc 
        count += 1
        count_in_direction(movement, count)
    end

    def winning_combination?
        pattern_counts = [horizontal_disc_count, vertical_disc_count,\
                        backwardslash_disc_count, forwardslash_disc_count]
        pattern_counts.any?{|count| count>=4}
    end

    def horizontal_disc_count
        left = -1
        right = 1
        count_in_direction(left) + count_in_direction(right) + SELF_COUNT 
    end
    
    def vertical_disc_count
        down = -10
        count_in_direction(down) + SELF_COUNT 
    end
    
    def forwardslash_disc_count
        right_top = 11
        left_down = -11
        count_in_direction(right_top) + count_in_direction(left_down) + SELF_COUNT 
    end
    
    def backwardslash_disc_count
        left_top = -9
        right_down = 9
        count_in_direction(left_top) + count_in_direction(right_down) + SELF_COUNT 
    end
end

