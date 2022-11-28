module Instructions
    def welcome_message
        puts 'Welcome to Connect4!!'
        puts 'You will be playing against a machine'
        puts "Your disc will be Green in color wheras machine's will be in red"
        puts 'Enter the column number where you want to slide in your disc'
    end

    def toss_winner(player)
        puts "#{player[:username]} will make the first move"
    end
end