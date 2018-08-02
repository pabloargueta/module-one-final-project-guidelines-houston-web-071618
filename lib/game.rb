$prompt = TTY::Prompt.new
def welcome
  puts "######################################################################"
  puts "######################################################################"
  puts "#########  Welcome to Marylene & Pablo's Trivia Game!  ###############"
  puts "#########                                              ###############"
  puts "######################################################################"
  puts "######################################################################"
end

def setup_display
  puts "######################################################################"
  puts "#########            Setup your game                   ###############"
  puts "#########       This is a two player game!             ###############"
  puts "######################################################################"
  puts "######### Don't hate the player, hate the game! ######################"
  puts "######################################################################"
end

def first_options
  first_option = $prompt.select("Please choose an option" , %w(start_game high_score))
end

def select_difficulty(questions_asked)
  user_input_dif = first_option = $prompt.select("Pick a difficulty from the list:" , %w(hard easy medium all))
  if user_input_dif != "all"
      question_difficulty_array = Question.select do |question|
        question.difficulty != user_input_dif
      end
      question_difficulty_array.each do |question|
        questions_asked << question.id
      end
    end
    questions_asked
end

def select_category(question_asked)
  user_input_dif = first_option = $prompt.select("Pick a category from the list:" , %w(sports films video_games science_computers general_knowledge music))
  if user_input_dif != "all"
      question_difficulty_array = Question.select do |question|
        question.difficulty != user_input_dif
      end
      question_difficulty_array.each do |question|
        questions_asked << question.id
      end
    end
    questions_asked
end

def highest_score
  highest_score = Score.maximum("score")
  highest_user = Score.find_by(score: highest_score).user.name
  system("clear")
  welcome
  puts "\n"
  puts "#{highest_user.capitalize} has the highest score with a total score of #{highest_score}"
  sleep(2)
end

def display_player_addition(player)
  system("clear")
  puts "######################################################################"
  puts "######################################################################"
  puts "#########            Setup your game                   ###############"
  puts "######################################################################"
  puts "Success, #{player.name.capitalize} you have been added to the game!"
  puts "\n"
  sleep(2)
  system("clear")
end

def display_returning_player(player)
  system("clear")
  puts "######################################################################"
  puts "######################################################################"
  puts "#########            Setup your game                   ###############"
  puts "######################################################################"
  puts "Welcome back, #{player.name.capitalize}!"
  puts "\n"
  sleep(2)
  system("clear")
end

def set_player
  system("clear")
  setup_display
  # take in players input for their player name
  puts "Enter Player's Name:"
  player_1 = gets.chomp.downcase
  find_player_1 = User.find_by(name: player_1)

  if find_player_1 == nil
    # create a new user
    player_1 = User.create(name: player_1)
    display_player_addition(player_1)
    player_1
  else
    # find existing player and show score
    display_returning_player(find_player_1)
    find_player_1
  end
end

def game_intro
  system("clear")
  puts "######################################################################"
  puts "######################################################################"
  puts "#########                Loading Game                  ###############"
  puts "######################################################################"
  sleep(1)
  puts "######################################################################"
  puts "#########                      3                       ###############"
  puts "######################################################################"
  sleep(1)
  puts "#########                      2                       ###############"
  puts "######################################################################"
  sleep(1)
  puts "#########                      1                       ###############"
  puts "######################################################################"
  sleep(1)
end

def create_question(questions_asked)
  id = rand(1..50)
  while questions_asked.include?(id) do
    id = rand(1..50)
  end
  questions_asked << id
  Question.find(id)
end

def print_question_to_console(question, player)
  option_array = []
  options = question.options.shuffle.each_with_index do |choice, index|
    option_array << "#{index+1}: #{choice.name}"
  end
  question_display(question, player)
  puts option_array
  options
end

def initialize_question(questions_asked, player)
  question = create_question(questions_asked)
  print_question_to_console(question, player)
end

def receive_player_response(current_options)
  puts "**************************************"
  puts "Please choose a valid answer"
  response = gets.chomp.to_i
  current_options[response - 1]
end

def question_display(question, player)
  system("clear")
  puts "######################################################################"
  puts "######################################################################"
  puts "#########                 I love trivia!               ###############"
  puts "######################################################################"
  puts "\n"
  puts  "#{player.name.capitalize} it's your turn!"
  sleep(1)
  puts "\n"
  puts "#{question.name}"
  puts "\n"
  sleep(2)
end

def response_right_display(player)
  system("clear")
  puts "######################################################################"
  puts "######################################################################"
  puts "#########                 I love trivia!               ###############"
  puts "######################################################################"
  puts "\n"
  puts  "#{player.name.capitalize} great job!"
  sleep(2)
end

def response_wrong_display(player, response)
  answer = response.question.options[0]
  system("clear")
  puts "######################################################################"
  puts "######################################################################"
  puts "#########                 I love trivia!               ###############"
  puts "######################################################################"
  puts "\n"
  puts  "Sorry #{player.name.capitalize} the correct answer is #{answer.name}"
  sleep(2)
end

def create_response(questions_asked, player)
  current_options = initialize_question(questions_asked, player)
  question = current_options[0].question
  response = receive_player_response(current_options)
  Response.create(user: player, question: question, option: response)
end

def player_turn(questions_asked, player)
  # puts "#{player.name}, your question is: "
  response = create_response(questions_asked, player)
  if response.option.is_correct
    response_right_display(player)
    return 1
  else
    response_wrong_display(player, response)
    sleep(3)
    return 0
  end
end

def save_score(player, score)
  Score.create(user: player, score: score)
end

def display_end_game(player1, player2, player1score, player2score)
  system("clear")
  puts "######################################################################"
  puts "######################################################################"
  puts "#########                 I love trivia!               ###############"
  puts "######################################################################"
  puts "\n"
  puts "This round has ended."
  puts "\n"
  user_input = $prompt.select("Do you want to end the game?" , %w(Yes No))

  if user_input == "Yes"
    save_score(player1, player1score)
    save_score(player2, player2score)
    return 1
  else 
    return 0
  end
end

def game(player_1, player_2)

  keep_playing = true
  questions_asked = []
  select_difficulty(questions_asked)
  # select_category(question_asked)
  player_1_score = 0
  player_2_score = 0

  question_counter = 0
  while keep_playing do
    player_1_score += player_turn(questions_asked, player_1)
    player_2_score += player_turn(questions_asked, player_2)
    question_counter +=1
      if question_counter == 1
        user_input = display_end_game(player_1, player_2, player_1_score, player_2_score)
        if user_input == 1
          break
        else
          question_counter = 0
        end
      end
  end
  # binding.pry
  system("ruby bin/run.rb")
end
