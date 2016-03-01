module FemisHangman
  class Router
    include(Message)
    attr_accessor :status, :difficulty, :feedback, :game
    def initialize
      @status = 'begin'
    end

    def process(input)
      if @status == 'begin' then welcome(input)
      elsif @status == 'feedback' then choose_feedback(input)
      elsif @status == 'start' then begin_game(input)
      elsif @status == 'play' then play_game(input)
      elsif @status == 'finish' then restart_game(input)
      elsif @status == 'load' then load_game(input)
      elsif @status == 'quit' then quit_game(input)
      else welcome(input)
      end
    end

    def welcome(input)
      case input
        when 'p', 'play' then start_game
        when 'q', 'quit' then quit_game
        when 'l', 'load' then show_saved_games
        when 'i', 'instructions' then puts instructions_prompt
        else puts invalid_prompt
      end
    end

    def start_game
      @status = 'feedback'
      puts welcome_prompt
      puts feedback_prompt
    end

    def choose_feedback(input)
      if input.to_i < 1 || input.to_i > 2
        puts invalid_prompt
        false
      else
        puts level_prompt
        @feedback = input.to_i
        @status = 'start'
      end
    end

    def begin_game(input)
      if input.to_i < 1 || input.to_i > 3
        puts invalid_prompt
      else
        @difficulty = input.to_i
        @status = 'play'
        create_game
      end
    end

    def create_game
      puts begin_prompt
      @game = Game.new(@difficulty, @feedback)
      puts size_prompt(@game.word.size)
      puts turns_prompt(@game.turns)
      puts game_instruction_prompt
      puts (@game.show_word)
    end

    def play_game(input)
      if @game.status == 'restart'
        restart_game(input)
      elsif @game.status == 'quit'
        quit_game(input)
      else @game.control(input)
      end
    end

    def restart_game(input)
      if input == 'r' || input == 'restart'
        puts level_prompt
        @status = 'start'
      elsif input == 'q' || input == 'quit' then quit_game
      else invalid_prompt
      end
    end

    def save_game(file='./saved_games.yaml')
      File.open(file, 'a'){|f| f.write(YAML.dump(@game))}
      @status = 'quit'
    end

    def show_saved_games
      @status = 'load'
      puts load_prompt
      counter = 0
      YAML.load_stream(File.open('./saved_games.yaml', 'r')).each do |game|
        counter += 1
        puts saved_games_list(counter, game)
      end
    end

    def saved_games_list(counter, game)
      "#{counter}: " << game.show_word << "(#{game.turns} turns left)"
    end

    def load_game(input)
      game_id = 0
      YAML.load_stream(File.open('./saved_games.yaml', 'r')).each do |game|
        game_id += 1
        if game_id == input.to_i then resume_game(game)
        else
          puts invalid_game_prompt
          show_saved_games
        end
      end
    end

    def resume_game(game)
      @game = game
      @status = 'play'
      @game.status = 'play'
      @game.check_game
    end

    def quit_game(input=nil)
      if input.nil? || input == 'q' || 'quit' then @status = 'quit'
      elsif input == 's' || 'save' then save_game
      else puts invalid_prompt
      end
    end

    def loop
      repl = lambda do |prompt|
        print prompt
        process(STDIN.gets.chomp.downcase)
      end
      repl['% Hangman-0.1.0: '] while @status != 'quit'
      puts thanks_prompt
    end
  end
end