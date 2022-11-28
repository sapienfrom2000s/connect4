class Mesh


    def initialize(grid)
        @grid = grid
    end
    
    def create
        (1..6).each do |height|
            (1..7).each do |column|
                current_grid = height*10+column
                @grid[current_grid][:left] = current_grid - 1 if left_available?(column)
                @grid[current_grid][:right] = current_grid + 1 if right_available?(column)
                @grid[current_grid][:bottom] = current_grid - 10 if bottom_available?(height)
                @grid[current_grid][:top_right] = current_grid + 11 if top_available?(height) && right_available?(column)
                @grid[current_grid][:top_left] = current_grid + 9 if top_available?(height) && left_available?(column)
                @grid[current_grid][:bottom_right] = current_grid - 9  if bottom_available?(height) && right_available?(column)
                @grid[current_grid][:bottom_left] = current_grid - 11 if bottom_available?(height) && left_available?(column)
            end
        end
    end

    def left_available?(column)
        true if column-1 >= 1
    end

    def right_available?(column)
        true if column+1 <= 7
    end

    def bottom_available?(height)
        true if height - 1 >= 1
    end

    def top_available?(height)
        true if height+1 <= 6
    end

end