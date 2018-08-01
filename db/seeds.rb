require_relative '../config/environment'


def get_questions_from_api
  #make the web request
  all_questions = RestClient.get('https://opentdb.com/api.php?amount=50&type=multiple')
  questions_hash = JSON.parse(all_questions)


  question_info= questions_hash["results"]


  question_info.each do |question_hash|
    question = Question.create(name: question_hash["question"], difficulty: question_hash['difficulty'])
    Option.create(name: question_hash["correct_answer"], is_correct: 1, question: question)

      question_hash["incorrect_answers"].each do |answer|
        Option.create(name: answer, is_correct: 0, question: question)

    end
  end

  return 0
end

# def self.save
  
get_questions_from_api
