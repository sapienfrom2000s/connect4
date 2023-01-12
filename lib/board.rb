class Board
    attr_reader :grid, :disc, :coordinate

    def initialize
        @grid = {}
        create_coordinates
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
end

