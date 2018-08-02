require_relative '../config/environment'
require 'rest-client'
require 'json'






# game_intro

# game(player_1, player_2)

def main

welcome
  first_user_input = 0
 while first_user_input != 1

   first_user_input = first_options
   if first_user_input == 1
     player_1 = set_player_1
     player_2 = set_player_2
     game(player_1, player_2)
   elsif first_user_input == 2
     highest_score
   end

 end

end

main
