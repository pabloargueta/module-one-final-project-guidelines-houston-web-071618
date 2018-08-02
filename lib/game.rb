def welcome
  puts "Welcome to Marylene & Pablo's Trivia Game!"
end

def first_options
  first_option = 0
  puts "Please choose an option below"
  while first_option != 1 && first_option != 2 do
    puts "1. Start Game  2. See highest Score"
    first_option = gets.chomp
    first_option = first_option.to_i
      if first_option != 1 && first_option != 2
        puts "Please choose a valid option"
      end
    
    end
    first_option
  end

def set_player_1
  # take in players input for their player name
  puts "Enter Player 1's Name:"
  player_1 = gets.chomp.downcase
  find_player_1 = User.find_by(name: player_1)


  if find_player_1 == nil
    # create a new user
    player_1 = User.create(name: player_1)
    puts "Success, #{player_1.name} you have been added to the game."
    player_1
  else
    # find existing player and show score
    puts "Welcome back, #{find_player_1.name}!"
    find_player_1
  end
end

def set_player_2
  puts "Enter Player 2's Name:"
  player_2 = gets.chomp.downcase
  find_player_2 = User.find_by(name: player_2)
  if find_player_2 == nil
    # create a new user
    player_2 = User.create(name: player_2)
    puts "Success, #{player_2.name} you have been added to the game."
    player_2
  else
    # find existing player and show score
    puts "Welcome back, #{find_player_2.name}!"
    find_player_2
  end
end

def game_intro
  sleep(3)
  puts "***************************Game is starting:*************************"
  sleep(3)
  puts "3"
  sleep(1)
  puts "2"
  sleep(1)
  puts "1"
  false
end

def create_question(questions_asked)
  id = rand(1..50)
  while questions_asked.include?(id) do
    id = rand(1..50)
  end
  questions_asked << id
  Question.find(id)
end

def print_question_to_console(question)
  puts question.name
  question.options.shuffle.each_with_index do |choice, index|
    puts "#{index+1}: #{choice.name}"
  end 
end

def initialize_question(questions_asked)
  question = create_question(questions_asked)
  print_question_to_console(question)
end

def receive_player_response(current_options)
  puts "**************************************"
  puts "Please choose a valid answer"
  response = gets.chomp.to_i
  current_options[response - 1]
end

def create_response(questions_asked, player)
  current_options = initialize_question(questions_asked)
  question = current_options[0].question
  response = receive_player_response(current_options)
  Response.create(user: player, question: question, option: response)
end




def player_turn(questions_asked, player)
  puts "#{player.name}, your question is: "
  response = create_response(questions_asked, player)
  
  if response.option.is_correct
    puts "#{player.name} great job!"
    sleep(3)
  else
    puts "Sorry better luck next time"
    sleep(3)
  end
end

def game(player_1, player_2)
  
  keep_playing = true
  questions_asked = []
  player_1_score = 0
  player_2_score = 0
  
  while keep_playing do
    player_turn(questions_asked, player_1)
    player_turn(questions_asked, player_2)


  end


  # need to get players from above

  # ask player 1 a question

  # if response == option[0] then is correct

  # add one to user.score

  # ask play 2 a question

  # if response == option[0] then is correct
  # add one to user.score


end