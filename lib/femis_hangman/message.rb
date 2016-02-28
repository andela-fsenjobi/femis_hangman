module Message
  def welcome_prompt
    puts 'Welcome to Hangman. Guess right or get hanged!'
  end

  def size_prompt(size)
    puts "Your word is a #{size} letter word"
  end

  def load_prompt
    puts "Choose the game you want to resume from the list below\nPress the respective number"
  end

  def begin_prompt
    puts "Let the games begin\n\n"
  end

  def instructions_prompt
    puts <<-PUTS
########################################################

This gem is an implementation of the hangman game.
Attempt to guess the missing letters correctly.
You have a limited number of tries.
If you use up all your chances without getting
the word correctly, you will be hanged.

To play a new game: Press 'p' or 'play'
To load a saved game: Press 'l' or 'load'
To show insructions: Press 'i' or 'instructions'
To quit Hangman: Press 'q' or 'quit'

########################################################
    PUTS
  end

  def save_prompt
    puts "Press 's' or 'save' to save before quiting\nPress 'q' to quit anyway"
  end

  def lost_prompt(word)
    puts "You are dead!\nThe word is #{word}"
    puts "Press any key to continue or 'q' to quit"
  end

  def won_prompt(word)
    puts "You win!\nThe word is #{word}"
  end

  def lost_gui(word)
    puts <<-PUTS
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
    PUTS
  end

  def won_gui(word)
    puts <<-PUTS
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
    PUTS
  end

  def level_prompt
    puts "Choose your difficulty level\n\n1: Beginner\n2: Intermediate\n3: Advanced\n"
  end

  def feedback_prompt
    puts "Choose your feedback type\n\n1: Boring\n2: Funny\n"
  end


  def replay_prompt
    puts "Press 'r' or 'restart' to play again\nPress 'q' to quit\n"
  end

  def invalid_prompt
    puts 'Invalid entry!'
  end

  def empty_prompt
    puts "You haven't used any letters yet."
  end

  def duplicate_prompt(letter)
    puts "You have used the letter #{letter} already"
  end

  def turns_prompt(turns)
    puts "You have #{turns} turns left"
  end

  def print_text(text)
    puts "#{text}"
  end

  def thanks_prompt
    puts 'Thank you for playing!'
  end

  def invalid_game_prompt
    puts 'There is no game with such ID'
  end

  def game_instruction_prompt
    puts <<-PUTS
Press ':h' or 'history' to view the letters you have used
Press ':q' or 'quit' to quit (you can save before quiting)

    PUTS
  end
end