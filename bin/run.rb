require_relative '../config/environment'
require 'rest-client'
require 'json'

welcome
first_user_input = first_options
if first_user_input == 1
  player_1 = set_player_1
  player_2 = set_player_2
end

game_intro

  game(player_1, player_2)


false


Question.find(questions_asked.last).options[0]