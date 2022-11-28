module Instructions
    def welcome_message
        puts 'Welcome to Connect4!!'
        puts 'Here, you will be playing on a 6X7 board'
        puts 'You will be playing against a machine'
        puts "Your disc will be Green in color wheras machine's will be in red"
        puts 'Enter the column number where you want to slide in your disc'
    end

    def toss_winner(player)
        puts "#{player[:username]} will make the first move"
    end

    def winning_message(username)
        puts "Congrats!, #{username} wins the game"
        puts 'Thanks for playing'
    end

    def draw_message
        puts "This game was a DRAW"
        puts 'Thanks for playing'
    end
end