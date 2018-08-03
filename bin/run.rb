require_relative '../config/environment'
require 'rest-client'
require 'json'






game_intro

# game(player_1, player_2)

def main
system("clear")
welcome
  first_user_input = 0
 while first_user_input != 1

   first_user_input = first_options
   if first_user_input == "start_game"
     player_1 = set_player
     player_2 = set_player
     game(player_1, player_2)
     main
   elsif first_user_input == "high_score"
     highest_score
     main
   end

 end

end

main
