module Message
  def welcome_prompt
    'Welcome to Hangman. Guess right or get hanged!'
  end

  def size_prompt(size)
    "Your word is a #{size} letter word"
  end

  def load_prompt
    "Choose the game you want to resume from the list below\nPress the respective number"
  end

  def begin_prompt
    "Let the games begin\n\n"
  end

  def instructions_prompt
    <<-PUTS
########################################################

Attempt to guess the missing letters correctly.
You have a limited number of tries.
If you use up all your chances without getting
the word correctly, you will be hanged.

To play a new game: Press 'p' or 'play'
To load a saved game: Press 'l' or 'load'
To show instructions: Press 'i' or 'instructions'
To quit Hangman: Press 'q' or 'quit'

########################################################
    PUTS
  end

  def save_prompt
    "Press 's' or 'save' to save before quiting\nPress 'q' to quit anyway"
  end

  def lost_prompt(word)
    "You are dead!\nThe word is #{word}\nPress any key to continue or 'q' to quit"
  end

  def won_prompt(word)
    "You win!\nThe word is #{word}"
  end

  def lost_gui(word)
    <<-HEREDOC
-+----------+-
 |          |
 |          o
 |         /|\\
 |         / \\
 |
 |
 |
You are dead!
################
The word is #{word}
################
    HEREDOC
  end

  def won_gui(word)
    <<-HEREDOC
-+----------+-
 |          |
 |
 |
 |           o/
 |          /|
 |         \\/ \\
 |            /
You are free to go
################
The word is #{word}
################
    HEREDOC
  end

  def level_prompt
    "Choose your difficulty level\n\n1: Beginner\n2: Intermediate\n3: Advanced\n"
  end

  def feedback_prompt
    "Choose your feedback type\n\n1: Boring\n2: Funny\n"
  end


  def replay_prompt
    "Press 'r' or 'restart' to play again\nPress 'q' to quit\n"
  end

  def invalid_prompt
    'Invalid entry!'
  end

  def empty_prompt
    "You haven't used any letters yet."
  end

  def duplicate_prompt(letter)
    "You have used the letter #{letter} already"
  end

  def turns_prompt(turns)
    "You have #{turns} turns left"
  end

  def print_text(text)
    "#{text}"
  end

  def thanks_prompt
    'Thank you for playing!'
  end

  def invalid_game_prompt
    'There is no game with such ID'
  end

#   def help_prompt
#     <<-HELP
# Press:
# hangman - to start the hangman game
# resume `game id` - to resume saved game
#     HELP
#   end

  def game_instruction_prompt
    <<-PUTS
Press ':h' or 'history' to view the letters you have used
Press ':q' or 'quit' to quit (you can save before quiting)

    PUTS
  end
end
