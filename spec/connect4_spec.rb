require_relative '../lib/board.rb'
require_relative '../lib/player.rb'
require_relative '../lib/computer.rb'
require_relative '../lib/gameplay.rb'
require_relative '../lib/mesh.rb'

describe Board do
    context 'when graph is a mesh of 7X6' do
        subject(:board){ Board.new }
        before{ board.create_coordinates }
        it 'returns the board with no moves made by either side' do
            default_board = "\n" + " ◯ ◯ ◯ ◯ ◯ ◯ ◯\n"*6 + "\n"
            expect(board.punch).to eq(default_board)
        end
    end
end

describe Player do
    subject(:player){Player.new}
    context 'when player is initialized' do
        it 'returns player name ' do
            allow(player).to receive(:gets).and_return("Rahman")
            expect(player.username).to eq("Rahman")
        end

        it 'returns player name' do
            allow(player).to receive(:gets).and_return("-=00")
            expect(player.username).to eq("-=00")
        end

        it 'returns disc for the player' do
            expect(player.disc).to eq('⬤'.colorize(:green))
        end
    end

    context 'when a human makes a valid move' do
        let(:grid) do
             {11=>{:self=>"◯"}, 12=>{:self=>"◯"}, 13=>{:self=>"◯"}, 14=>{:self=>"◯"}, 15=>{:self=>"◯"}, 16=>{:self=>"◯"},17=>{:self=>"◯"},
             21=>{:self=>"◯"}, 22=>{:self=>"◯"}, 23=>{:self=>"◯"}, 24=>{:self=>"◯"}, 25=>{:self=>"◯"}, 26=>{:self=>"◯"}, 27=>{:self=>"◯"},
              31=>{:self=>"◯"}, 32=>{:self=>"◯"}, 33=>{:self=>"◯"}, 34=>{:self=>"◯"}, 35=>{:self=>"◯"}, 36=>{:self=>"◯"}, 37=>{:self=>"◯"}, 
              41=>{:self=>"◯"}, 42=>{:self=>"◯"}, 43=>{:self=>"◯"}, 44=>{:self=>"◯"}, 45=>{:self=>"◯"}, 46=>{:self=>"◯"}, 47=>{:self=>"◯"}, 
              51=>{:self=>"◯"}, 52=>{:self=>"◯"}, 53=>{:self=>"◯"}, 54=>{:self=>"◯"}, 55=>{:self=>"◯"}, 56=>{:self=>"◯"}, 57=>{:self=>"◯"},
             61=>{:self=>"◯"}, 62=>{:self=>"◯"}, 63=>{:self=>"◯"}, 64=>{:self=>"◯"}, 65=>{:self=>"◯"}, 66=>{:self=>"◯"}, 67=>{:self=>"◯".colorize(:green)}}
        end
        subject(:game) {Gameplay.new}
        it 'returns move' do
            allow(player).to receive(:gets).and_return('9','55','777','-666','-6','7','4')
            expect(player.move(grid)).to eq(4)
        end
        
    end
end

describe Computer do
    subject(:computer){Computer.new}
    context 'when computer is initialized' do
        it 'returns computer disc' do
            expect(computer.disc).to eq('⬤'.colorize(:red))
        end
    end

    context 'when a move is requested from computer' do
        it 'returns a valid move' do
            move = computer.move
            expect(move).to be >=1
            expect(move).to be <=7
        end
    end
end

describe Gameplay do
    # subject(:game){Gameplay.new}
    context 'when player has requested for the disc to be dropped' do
        let(:grid) do
            {11=>{:self=>"◯"}, 12=>{:self=>"◯"}, 13=>{:self=>"◯"}, 14=>{:self=>"◯"}, 15=>{:self=>"◯"}, 16=>{:self=>"◯"},17=>{:self=>"◯"},
             21=>{:self=>"◯"}, 22=>{:self=>"◯"}, 23=>{:self=>"◯"}, 24=>{:self=>"◯"}, 25=>{:self=>"◯"}, 26=>{:self=>"◯"}, 27=>{:self=>"◯"},
             31=>{:self=>"◯"}, 32=>{:self=>"◯"}, 33=>{:self=>"◯"}, 34=>{:self=>"◯"}, 35=>{:self=>"◯"}, 36=>{:self=>"◯"}, 37=>{:self=>"◯"}, 
             41=>{:self=>"◯"}, 42=>{:self=>"◯"}, 43=>{:self=>"◯"}, 44=>{:self=>"◯"}, 45=>{:self=>"◯"}, 46=>{:self=>"◯"}, 47=>{:self=>"◯"}, 
             51=>{:self=>"◯"}, 52=>{:self=>"◯"}, 53=>{:self=>"◯"}, 54=>{:self=>"◯"}, 55=>{:self=>"◯"}, 56=>{:self=>"◯"}, 57=>{:self=>"◯"},
             61=>{:self=>"◯"}, 62=>{:self=>"◯"}, 63=>{:self=>"◯"}, 64=>{:self=>"◯"}, 65=>{:self=>"◯"}, 66=>{:self=>"◯"}, 67=>{:self=>"◯"}}
       end
        it 'returns updated grid' do
            disc = '⬤'.colorize(:red)
            game = Gameplay.new(grid)
            expect{game.drop_the_disc(disc,6)}.to change { grid[16][:self] }.from("◯").to("⬤".colorize(:red))
            expect{game.drop_the_disc(disc,6)}.to change { grid[26][:self] }.from("◯").to("⬤".colorize(:red))            
        end
    end

    context 'when move is played, check for horizontal clearance' do
        let(:grid) do
            {11=>{:self=>"◯"}, 12=>{:self=>"◯".colorize(:red)}, 13=>{:self=>"◯".colorize(:green)}, 14=>{:self=>"◯".colorize(:green)}, 15=>{:self=>"◯".colorize(:green)}, 16=>{:self=>"◯".colorize(:green)},17=>{:self=>"◯".colorize(:green)},
            21=>{:self=>"◯"}, 22=>{:self=>"◯"}, 23=>{:self=>"◯"}, 24=>{:self=>"◯"}, 25=>{:self=>"◯"}, 26=>{:self=>"◯"}, 27=>{:self=>"◯"},
            31=>{:self=>"◯"}, 32=>{:self=>"◯"}, 33=>{:self=>"◯"}, 34=>{:self=>"◯"}, 35=>{:self=>"◯"}, 36=>{:self=>"◯"}, 37=>{:self=>"◯"}, 
            41=>{:self=>"◯"}, 42=>{:self=>"◯"}, 43=>{:self=>"◯"}, 44=>{:self=>"◯"}, 45=>{:self=>"◯"}, 46=>{:self=>"◯"}, 47=>{:self=>"◯"}, 
            51=>{:self=>"◯"}, 52=>{:self=>"◯"}, 53=>{:self=>"◯"}, 54=>{:self=>"◯"}, 55=>{:self=>"◯"}, 56=>{:self=>"◯"}, 57=>{:self=>"◯"},
            61=>{:self=>"◯"}, 62=>{:self=>"◯"}, 63=>{:self=>"◯"}, 64=>{:self=>"◯"}, 65=>{:self=>"◯"}, 66=>{:self=>"◯"}, 67=>{:self=>"◯"}}
    
        end
       it 'returns true' do
        game = Gameplay.new(grid)
        mesh = Mesh.new(grid)
        mesh.create
        expect(game.horizontal_clearance?(13,"◯".colorize(:green))).to be true
       end

       it 'returns not true when no horizontal match' do
        game = Gameplay.new(grid)
        mesh = Mesh.new(grid)
        mesh.create
        expect(game.horizontal_clearance?(12,"◯".colorize(:red))).not_to be true 
       end

       it 'returns nil if a red disc comes in between' do
            game = Gameplay.new(grid)
            mesh = Mesh.new(grid)
            mesh.create
            grid[15][:self] = "◯".colorize(:red)
            expect(game.horizontal_clearance?(14,"◯".colorize(:green))).to_not be true
       end

       it 'returns nil when unable to complete 4 in a row' do
            game = Gameplay.new(grid)
            mesh = Mesh.new(grid)
            mesh.create
            grid[16][:self],grid[17][:self] = "◯","◯"
            expect(game.horizontal_clearance?(14,"◯".colorize(:green))).to_not be true
       end

   end




    context 'when move is played, check for vertical clearance' do
        let(:grid) do
            {11=>{:self=>"◯"}, 12=>{:self=>"◯".colorize(:red)}, 13=>{:self=>"◯".colorize(:green)}, 14=>{:self=>"◯".colorize(:green)}, 15=>{:self=>"◯".colorize(:green)}, 16=>{:self=>"◯".colorize(:green)},17=>{:self=>"◯".colorize(:green)},
            21=>{:self=>"◯"}, 22=>{:self=>"◯".colorize(:red)}, 23=>{:self=>"◯"}, 24=>{:self=>"◯"}, 25=>{:self=>"◯"}, 26=>{:self=>"◯"}, 27=>{:self=>"◯"},
            31=>{:self=>"◯"}, 32=>{:self=>"◯".colorize(:red)}, 33=>{:self=>"◯"}, 34=>{:self=>"◯"}, 35=>{:self=>"◯"}, 36=>{:self=>"◯"}, 37=>{:self=>"◯"}, 
            41=>{:self=>"◯"}, 42=>{:self=>"◯".colorize(:red)}, 43=>{:self=>"◯"}, 44=>{:self=>"◯"}, 45=>{:self=>"◯"}, 46=>{:self=>"◯"}, 47=>{:self=>"◯"}, 
            51=>{:self=>"◯"}, 52=>{:self=>"◯"}, 53=>{:self=>"◯"}, 54=>{:self=>"◯"}, 55=>{:self=>"◯"}, 56=>{:self=>"◯"}, 57=>{:self=>"◯"},
            61=>{:self=>"◯"}, 62=>{:self=>"◯"}, 63=>{:self=>"◯"}, 64=>{:self=>"◯"}, 65=>{:self=>"◯"}, 66=>{:self=>"◯"}, 67=>{:self=>"◯"}}
    
        end
       it 'returns true' do
        game = Gameplay.new(grid)
        mesh = Mesh.new(grid)
        mesh.create
        expect(game.vertical_clearance?(42,"◯".colorize(:red))).to be true
       end

       it 'returns nil when no horizontal match' do
        game = Gameplay.new(grid)
        mesh = Mesh.new(grid)
        mesh.create
        expect(game.vertical_clearance?(13,"◯".colorize(:red))).to be nil 
       end

       it 'returns nil if a red disc comes in between' do
            game = Gameplay.new(grid)
            mesh = Mesh.new(grid)
            mesh.create
            grid[12][:self] = "◯".colorize(:red)
            expect(game.vertical_clearance?(42,"◯".colorize(:green))).to be nil
       end

    end

    context 'when move is played, check for forward slash clearance' do
        let(:grid) do
            {11=>{:self=>"◯"}, 12=>{:self=>"◯".colorize(:red)}, 13=>{:self=>"◯".colorize(:green)}, 14=>{:self=>"◯".colorize(:green)}, 15=>{:self=>"◯".colorize(:green)}, 16=>{:self=>"◯".colorize(:green)},17=>{:self=>"◯".colorize(:green)},
            21=>{:self=>"◯"}, 22=>{:self=>"◯".colorize(:red)}, 23=>{:self=>"◯".colorize(:red)}, 24=>{:self=>"◯"}, 25=>{:self=>"◯"}, 26=>{:self=>"◯"}, 27=>{:self=>"◯"},
            31=>{:self=>"◯"}, 32=>{:self=>"◯".colorize(:red)}, 33=>{:self=>"◯"}, 34=>{:self=>"◯".colorize(:red)}, 35=>{:self=>"◯"}, 36=>{:self=>"◯"}, 37=>{:self=>"◯"}, 
            41=>{:self=>"◯"}, 42=>{:self=>"◯".colorize(:red)}, 43=>{:self=>"◯"}, 44=>{:self=>"◯"}, 45=>{:self=>"◯".colorize(:red)}, 46=>{:self=>"◯"}, 47=>{:self=>"◯"}, 
            51=>{:self=>"◯"}, 52=>{:self=>"◯"}, 53=>{:self=>"◯"}, 54=>{:self=>"◯"}, 55=>{:self=>"◯"}, 56=>{:self=>"◯"}, 57=>{:self=>"◯"},
            61=>{:self=>"◯"}, 62=>{:self=>"◯"}, 63=>{:self=>"◯"}, 64=>{:self=>"◯"}, 65=>{:self=>"◯"}, 66=>{:self=>"◯"}, 67=>{:self=>"◯"}}
    
        end
       it 'returns true' do
        game = Gameplay.new(grid)
        mesh = Mesh.new(grid)
        mesh.create
        expect(game.forward_slash_clearance?(23,"◯".colorize(:red))).to be true
       end

       it 'returns nil when no forward slash match' do
        game = Gameplay.new(grid)
        mesh = Mesh.new(grid)
        mesh.create
        expect(game.forward_slash_clearance?(14,"◯".colorize(:red))).to be nil 
       end

       it 'returns nil if a green disc comes in between' do
            game = Gameplay.new(grid)
            mesh = Mesh.new(grid)
            mesh.create
            grid[34][:self] = "◯".colorize(:green)
            expect(game.forward_slash_clearance?(23,"◯".colorize(:red))).to be nil
       end

    end

    context 'when move is played, check for forward slash clearance' do
        let(:grid) do
            {11=>{:self=>"◯"}, 12=>{:self=>"◯".colorize(:red)}, 13=>{:self=>"◯".colorize(:green)}, 14=>{:self=>"◯".colorize(:green)}, 15=>{:self=>"◯".colorize(:green)}, 16=>{:self=>"◯".colorize(:green)},17=>{:self=>"◯".colorize(:green)},
            21=>{:self=>"◯"}, 22=>{:self=>"◯".colorize(:red)}, 23=>{:self=>"◯".colorize(:green)}, 24=>{:self=>"◯"}, 25=>{:self=>"◯"}, 26=>{:self=>"◯"}, 27=>{:self=>"◯".colorize(:red)},
            31=>{:self=>"◯"}, 32=>{:self=>"◯".colorize(:green)}, 33=>{:self=>"◯"}, 34=>{:self=>"◯".colorize(:red)}, 35=>{:self=>"◯"}, 36=>{:self=>"◯".colorize(:red)}, 37=>{:self=>"◯"}, 
            41=>{:self=>"◯".colorize(:green)}, 42=>{:self=>"◯".colorize(:red)}, 43=>{:self=>"◯"}, 44=>{:self=>"◯"}, 45=>{:self=>"◯".colorize(:red).colorize(:red)}, 46=>{:self=>"◯"}, 47=>{:self=>"◯"}, 
            51=>{:self=>"◯"}, 52=>{:self=>"◯"}, 53=>{:self=>"◯"}, 54=>{:self=>"◯".colorize(:red)}, 55=>{:self=>"◯".colorize(:red)}, 56=>{:self=>"◯"}, 57=>{:self=>"◯"},
            61=>{:self=>"◯"}, 62=>{:self=>"◯"}, 63=>{:self=>"◯"}, 64=>{:self=>"◯"}, 65=>{:self=>"◯"}, 66=>{:self=>"◯"}, 67=>{:self=>"◯"}}
    
        end
       it 'returns true' do
        game = Gameplay.new(grid)
        mesh = Mesh.new(grid)
        mesh.create
        expect(game.backward_slash_clearance?(32,"◯".colorize(:green))).to be true
       end

       it 'returns nil when no forward slash match' do
        game = Gameplay.new(grid)
        mesh = Mesh.new(grid)
        mesh.create
        expect(game.backward_slash_clearance?(42,"◯".colorize(:red))).to be nil 
       end

       it 'returns nil if a green disc comes in between' do
            game = Gameplay.new(grid)
            mesh = Mesh.new(grid)
            mesh.create
            grid[14][:self] = "◯".colorize(:green)
            expect(game.backward_slash_clearance?(32,"◯".colorize(:red))).to be nil
       end

    end


end












describe Mesh do
    
    let(:grid) do
        {11=>{:self=>"◯"}, 12=>{:self=>"◯"}, 13=>{:self=>"◯"}, 14=>{:self=>"◯"}, 15=>{:self=>"◯"}, 16=>{:self=>"◯"},17=>{:self=>"◯"},
        21=>{:self=>"◯"}, 22=>{:self=>"◯"}, 23=>{:self=>"◯"}, 24=>{:self=>"◯"}, 25=>{:self=>"◯"}, 26=>{:self=>"◯"}, 27=>{:self=>"◯"},
        31=>{:self=>"◯"}, 32=>{:self=>"◯"}, 33=>{:self=>"◯"}, 34=>{:self=>"◯"}, 35=>{:self=>"◯"}, 36=>{:self=>"◯"}, 37=>{:self=>"◯"}, 
        41=>{:self=>"◯"}, 42=>{:self=>"◯"}, 43=>{:self=>"◯"}, 44=>{:self=>"◯"}, 45=>{:self=>"◯"}, 46=>{:self=>"◯"}, 47=>{:self=>"◯"}, 
        51=>{:self=>"◯"}, 52=>{:self=>"◯"}, 53=>{:self=>"◯"}, 54=>{:self=>"◯"}, 55=>{:self=>"◯"}, 56=>{:self=>"◯"}, 57=>{:self=>"◯"},
        61=>{:self=>"◯"}, 62=>{:self=>"◯"}, 63=>{:self=>"◯"}, 64=>{:self=>"◯"}, 65=>{:self=>"◯"}, 66=>{:self=>"◯"}, 67=>{:self=>"◯"}}
    end
    subject(:mesh){Mesh.new(grid)}
    before{ mesh.create } 
    context ' when mesh of connect4 is created' do 
        it 'receives left coordinate' do
            expect(grid[62][:left]).to eq(61)
        end

        it 'doesnt receive any left coordinate when on left edge' do
            expect(grid[61].has_key?(:left)).to be false 
        end

        it 'doesnt receive any top coordinate when on top edge' do
            expect(grid[61].has_key?(:top)).to be false
        end

        it 'doesnt receive any bottom coordinate when on bottom edge' do
            expect(grid[16].has_key?(:bottom)).to be false
        end

        it 'doesnt receive any right coordinate when on right edge' do
            expect(grid[17].has_key?(:right)).to be false
        end

        it 'receives bottom coordinate' do
            expect(grid[62][:bottom]).to eq(52)
        end

        it 'receives right coordinate' do
            expect(grid[62][:right]).to eq(63)
        end

        it 'receives bottom left coordinate' do
            expect(grid[62][:bottom_left]).to eq(51)
        end

        it 'receives bottom right coordinate' do
            expect(grid[62][:bottom_right]).to eq(53)
        end

        it 'receives top left coordinate' do
            expect(grid[12][:top_left]).to eq(21)
        end

        it 'receives top right coordinate' do
            expect(grid[44][:top_right]).to eq(55)
        end

   end
end
