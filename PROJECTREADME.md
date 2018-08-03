#### Trivia game using TRIVIA API

### The Trivia Game is a fun two player game:
At the start of the game, the user will be prompted with two options - 1) Start a game or 2) View the Highest Score. If the user choses to start a game, the players will be prompted to pick a level of difficulty and a category. Each player will enter their name and it will be saved as a new player name or if a returning player, they will be welcomed back. Each player will be asked a trivia question with the option to choose 1 of 4 multiple choice answers. The player will select an answer and the Trivia Game will respond if the answer was correct or provide the correct answer. Then it will be the next player's turn, and will be prompted with a question. After the round of questions, the players will have a choice to continue playing or stop the game and directed back to the main menu. By selecting 2) Highest Score, they can see if either player has the highest score.

###Install instructions:
Use the link below to git clone locally.
In your terminal type in:
ruby bin/run.rb


Link to the license for your code: https://github.com/pabloargueta/module-one-final-project-guidelines-houston-web-071618

<!-- Queries to call in Rake Console -->
###Player
1. Each player has a name
<!-- User.find(1).name -->
2. Each player has many scores
<!-- User.find(1).scores -->

###Score
1. A score belongs to a player
<!-- First that matches criteria in the DB: Score.find_by(user_id: 1) -->
<!-- All that match criteria in the DB: Score.where(user_id:1) -->
2. The Trivia game will give the name of the player with the all time highest score
<!-- highest_score = Score.maximum("score") -->
<!-- highest_user = Score.find_by(score: highest_score).user.name -->

###Response
1. A response belongs to a user
<!-- First that matches criteria in the DB: Response.find_by(user_id: 1) -->
<!-- All that match criteria in the DB: Response.where(user_id: 1) -->
2. A response belongs to a question
<!-- If the said question has been responded to Response.where(question_id: 35) -->
3. A response belongs to an option
<!-- If the said option has been responded to Response.where(option_id:137) -->

###Question
1. A question has many responses
<!-- If the said question has been responded to Question.find(35).responses -->
2. A question has many options
<!-- Question.find(35).options -->
3. A question has many users through responses
<!-- Question.find(35).users -->

###Option
1. A option belongs to a question
<!-- Option.find_by(question_id:35) -->
<!-- Option.where(question_id:35) -->
2. A option has many responses
<!-- If the said option has been responded to Option.where(response_id:1) -->