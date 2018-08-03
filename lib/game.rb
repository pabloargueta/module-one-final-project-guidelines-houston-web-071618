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
  first_option = $prompt.select("Please choose an option" , %w(Start_game High_score)).downcase
end

def select_cat_dif(questions_asked)
  setup_display
  puts "\n"
  user_input_cat_dif = $prompt.select("Pick Questions by Difficulty or Category:" , %w(Difficulty Category)).downcase
  if user_input_cat_dif == "difficulty"
    system("clear")
    select_difficulty(questions_asked)
  else user_input_cat_dif == "category"
    system("clear")
    select_category(questions_asked)
  end
  questions_asked
end

def select_difficulty(questions_asked)
  setup_display
  puts "\n"
  user_input_dif = $prompt.select("Pick a difficulty from the list:" , %w(All Easy Medium Hard)).downcase
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

def select_category(questions_asked)
  setup_display
  puts "\n"
  user_input_cat = $prompt.select("Pick a category from the list:", %w(All Sports Films Video_Games Science_Computers General_knowledge Music)).downcase
  case user_input_cat
    when "sports"
      questions_asked << Question.where.not(category: "Sports").ids
    when "films"
      questions_asked << Question.where.not(category: "Entertainment: Film").ids
    when "video_games"
      questions_asked << Question.where.not(category: "Entertainment: Video Games").ids
    when "science_computers"
      questions_asked << Question.where.not(category: "Science: Computers").ids
    when "general_knowledge"
      questions_asked << Question.where.not(category: "General Knowledge").ids
    when "music"
      questions_asked << Question.where.not(category: "Entertainment: Music").ids
  end
   questions_asked.flatten
end

# def select_difficulty(questions_asked)
#   setup_display
#   puts "\n"
#   user_input_dif = first_option = $prompt.select("Pick a difficulty from the list:" , %w(All Easy Medium Hard)).downcase
#   if user_input_dif != "all"
#       question_difficulty_array = Question.select do |question|
#         question.difficulty != user_input_dif
#       end
#       question_difficulty_array.each do |question|
#         questions_asked << question.id
#       end
#     end
#     questions_asked
# end

# def select_category(questions_asked)
#   user_input_dif = first_option = $prompt.select("Pick a category from the list:" , %w(sports films video_games science_computers general_knowledge music))
#   if user_input_dif != "all"
#       question_difficulty_array = Question.select do |question|
#         question.difficulty != user_input_dif
#       end
#       question_difficulty_array.each do |question|
#         questions_asked << question.id
#       end
#     end
#     questions_asked
# end

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
  setup_display
  puts "\n"
  puts "Success, #{player.name.capitalize} you have been added to the game!"
  puts "\n"
  sleep(1.5)
  system("clear")
end

def display_returning_player(player)
  system("clear")
  setup_display
  puts "\n"
  puts "Welcome back, #{player.name.capitalize}!"
  puts "\n"
  sleep(1.5)
  system("clear")
end

def set_player
  system("clear")
  setup_display
  puts "\n"
  # take in players input for their player name
  # puts "Enter Player's Name:"
  player_1 = $prompt.ask('What is your name?', required: true)

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

def loading_screen
  system("clear")
  puts "######################################################################"
  puts "######################################################################"
  puts "#########         Loading Trivia Game                  ###############"
  puts "######################################################################"
end

def game_intro
  loading_screen
  # sleep(1)
  # puts "######################################################################"
  # puts "#########                      3                       ###############"
  # puts "######################################################################"
  # sleep(1)
  # puts "#########                      2                       ###############"
  # puts "######################################################################"
  # sleep(1)
  # puts "#########                      1                       ###############"
  # puts "######################################################################"
  # sleep(1)
  puts "\n"

  puts_array = ""

  for i in 1..70
    loading_screen
    puts_array += "#"
    puts puts_array
    puts puts_array
    sleep(0.015)
  end
end

def create_question(questions_asked)
  total_questions = Question.all.length
  id = rand(1..total_questions)
  while questions_asked.include?(id) do
    id = rand(1..total_questions)
  end
  questions_asked << id
  Question.find(id)
end

def print_question_to_console(question, player)
  options = question.options.shuffle
  question_display(question, player)
  # puts option_array
  options
end

def initialize_question(questions_asked, player)
  question = create_question(questions_asked)
  print_question_to_console(question, player)
end

def receive_player_response(current_options)
  option_array =[]
  current_options.each do |choice|
    parsed_name = Nokogiri::HTML.parse "#{choice.name}"
    option_array << "#{parsed_name.text}"
  end
  response = $prompt.enum_select("Select below", option_array)[0].to_i
  current_options[response - 1]
end

def in_game_display
  system("clear")
  puts "######################################################################"
  puts "######################################################################"
  puts "#########                 I love trivia!               ###############"
  puts "######################################################################"
end

def question_display(question, player)
  in_game_display
  puts "\n"
  puts  "#{player.name.capitalize} it's your turn!"
  sleep(0.5)
  puts "\n"
  question_name = Nokogiri::HTML.parse "#{question.name}"
  puts question_name.text
  puts "\n"
  sleep(1)
end

def response_right_display(player)
  in_game_display
  puts "\n"
  puts  "#{player.name.capitalize} great job!"
  puts "\n"
  puts "\n"
  sleep(0.5)
  $prompt.keypress("Press space or enter to continue", keys: [:space, :return])
end

def response_wrong_display(player, response)
  answer = response.question.options[0]
 in_game_display
  puts "\n"
  puts  "Sorry #{player.name.capitalize} the correct answer is #{answer.name}"
  puts "\n"
  puts "\n"
  sleep(0.5)
  $prompt.keypress("Press space or enter to continue", keys: [:space, :return])
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
    return 0
  end
end

def end_game_display
  system("clear")
  puts "######################################################################"
  puts "######################################################################"
  puts "#########        Thank you for playing trivia!         ###############"
  puts "######################################################################"
end

def save_score(player, score)
  Score.create(user: player, score: score)
  end_game_display
end

def display_end_game(player1, player2, player1score, player2score)
  in_game_display
  puts "\n"
  puts "This round has ended."
  puts "\n"
  user_input = $prompt.select("Do you want to Continue to the next round?" , %w(Yes No)).downcase

  if user_input == "no"
    save_score(player1, player1score)
    save_score(player2, player2score)
    sleep(2)
    return 1
  else 
    return 0
  end
end

def game(player_1, player_2)

  keep_playing = true
  questions_asked = []
  questions_asked = select_cat_dif(questions_asked).flatten
  
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
end
