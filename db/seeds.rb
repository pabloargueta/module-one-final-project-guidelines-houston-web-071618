require_relative '../config/environment'


def get_questions_from_api(url)
  #make the web request
  all_questions = RestClient.get(url)
  questions_hash = JSON.parse(all_questions)


  question_info= questions_hash["results"]


  question_info.each do |question_hash|
    question = Question.create(name: question_hash["question"], difficulty: question_hash["difficulty"], category: question_hash["category"])
    Option.create(name: question_hash["correct_answer"], is_correct: 1, question: question)

      question_hash["incorrect_answers"].each do |answer|
        Option.create(name: answer, is_correct: 0, question: question)

    end
  end

  return 0
end
sports = 'https://opentdb.com/api.php?amount=50&category=21&type=multiple'
films = 'https://opentdb.com/api.php?amount=50&category=11&type=multiple'
video_games = 'https://opentdb.com/api.php?amount=50&category=15&type=multiple'
science_computers = 'https://opentdb.com/api.php?amount=50&category=18&type=multiple'
general_knowledge = 'https://opentdb.com/api.php?amount=50&category=9&type=multiple'
music = 'https://opentdb.com/api.php?amount=50&category=12&type=multiple'
# def self.save
  
get_questions_from_api(sports)
get_questions_from_api(films)
get_questions_from_api(video_games)
get_questions_from_api(science_computers)
get_questions_from_api(general_knowledge)
get_questions_from_api(music)


