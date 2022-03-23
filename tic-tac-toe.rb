
class Player
    def initialize(name, symbol)
        @name = name
        @symbol = symbol
    end

    def get_symbol
        @symbol
    end
    
    def get_name
        @name
    end
end

class TicTacToeInternal
    @@GRIDVALUE = [[1,2,3],[4,5,6],[7,8,9]]
    @@FIND_WINNER = 0
    
    def update_grid
        c_bar = " ! "
        v_bar = "--+---+--"
        
        puts ""
        for i in 0..2
            for a in 0..2
               print "#{@@GRIDVALUE[i][a]}#{c_bar}" if a < 2
               puts @@GRIDVALUE[i][a] if a == 2
               puts v_bar if a == 2 && i != 2
            end
        end
    end

    def player_pick(player)
        puts ""
        puts "#{player.get_name} pick a position"
        puts "available position ->  #{@@GRIDVALUE.flatten.select {|pos| pos.is_a? Integer}}"
        puts ""

        pick = gets
        pick = pick.chomp.to_i
        check = false

        unless @@GRIDVALUE.flatten.include? pick
            until check == true
                puts "illegal input: available position  #{@@GRIDVALUE.flatten.select{|pos| pos.is_a? Integer}}" if check == false
                puts ""
                pick = gets
                pick = pick.chomp.to_i
                check = true if @@GRIDVALUE.flatten.include? pick
            end
        end

        index_1 = @@GRIDVALUE.find_index{|arr| arr.index(pick)}
        index_2 = @@GRIDVALUE[index_1].index(pick)

        @@GRIDVALUE[index_1][index_2] = player.get_symbol
    end

    def a_winner(p1, p2)
        for i in 0..2
            if @@GRIDVALUE[i][0] == @@GRIDVALUE[i][1] && @@GRIDVALUE[i][0] == @@GRIDVALUE[i][2]
                @@FIND_WINNER += 1 if @@GRIDVALUE[i][0] == p1.get_symbol
                @@FIND_WINNER += 2 if @@GRIDVALUE[i][0] == p2.get_symbol
                return true
            end

            if @@GRIDVALUE[0][i] == @@GRIDVALUE[1][i] && @@GRIDVALUE[0][i] == @@GRIDVALUE[2][i]
                @@FIND_WINNER += 1 if @@GRIDVALUE[0][i] == p1.get_symbol
                @@FIND_WINNER += 2 if @@GRIDVALUE[0][i] == p2.get_symbol
                return true
            end
        end

        if @@GRIDVALUE[0][0] == @@GRIDVALUE[1][1] && @@GRIDVALUE[0][0] == @@GRIDVALUE[2][2]
            @@FIND_WINNER += 1 if @@GRIDVALUE[0][0] == p1.get_symbol
            @@FIND_WINNER += 2 if @@GRIDVALUE[0][0] == p2.get_symbol
            return true
        end

        if @@GRIDVALUE[0][2] == @@GRIDVALUE[1][1] && @@GRIDVALUE[0][2] == @@GRIDVALUE[2][0]
            @@FIND_WINNER += 1 if @@GRIDVALUE[0][2] == p1.get_symbol
            @@FIND_WINNER += 2 if @@GRIDVALUE[0][2] == p2.get_symbol
            return true
        end

        return @@GRIDVALUE.flatten.all?{ |val| val.is_a? String}
    end
    
    def winner(p1, p2)
        the_winner = @@FIND_WINNER
        puts ""
        puts "#{p1.get_name} wins!" if the_winner == 1
        puts "#{p2.get_name} wins!" if the_winner == 2
        puts "its a draw!" if the_winner == 0
        puts ""
    end
end

puts ""
puts "play tic-tac-toe against friend"
puts ""

puts "player 1 enter a name"
p1_name = gets
p1_name = p1_name.chomp

puts ""
puts "player 1 pick a symbol (x or o)"
p1_sym = gets
p1_sym = p1_sym.chomp.downcase

unless p1_sym == "x" || p1_sym == "o"
    until p1_sym == "x" || p1_sym == "o"
        puts ""
        puts "--< pick x or o >--"
        p1_sym = gets
        p1_sym = p1_sym.chomp.downcase
    end
end

puts ""
puts "player 2 enter a name"

p2_name = gets
p2_name = p2_name.chomp
p2_sym = "x" if p1_sym == "o"
p2_sym = "o" if p1_sym == "x"

player_1 = Player.new(p1_name, p1_sym)
player_2 = Player.new(p2_name, p2_sym)

game = TicTacToeInternal.new
end_game = game.a_winner(player_1, player_2)
game.update_grid

until end_game
    game.player_pick(player_1)
    game.update_grid
    end_game = game.a_winner(player_1, player_2)
    break if end_game

    game.player_pick(player_2)
    game.update_grid
    end_game = game.a_winner(player_1, player_2)
end

game.winner(player_1, player_2)
