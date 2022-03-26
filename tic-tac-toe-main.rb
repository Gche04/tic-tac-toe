require_relative 'tic-tac-toe'

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