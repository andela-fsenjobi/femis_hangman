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
      elsif @status == 'quit' || 'save' then quit_game(input)
      else welcome(input)
      end
    end

    def welcome(input)
      case input
        when 'p', 'play' then start_game
        when 'q', 'quit' then quit_game
        when 'l', 'load' then show_saved_games
        when 'i', 'instructions' then instructions_prompt
        else invalid_prompt
      end
    end

    def start_game
      @status = 'feedback'
      welcome_prompt
      feedback_prompt
    end

    def choose_feedback(input)
      if input.to_i < 1 || input.to_i > 2
        invalid_prompt
      else
        level_prompt
        @feedback = input.to_i
        @status = 'start'
      end
    end

    def begin_game(input)
      @difficulty = input.to_i
      if @difficulty < 1 || @difficulty > 3
        invalid_prompt
      else
        @status = 'play'
        create_game
      end
    end

    def create_game
      begin_prompt
      @game = Game.new(@difficulty, @feedback)
      size_prompt(@game.word.size)
      turns_prompt(@game.turns)
      game_instruction_prompt
      print_text(@game.show_word)
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
        level_prompt
        @status = 'start'
      elsif input == 'q' || input == 'quit' then quit_game
      else invalid_prompt
      end
    end

    def save_game
      File.open('./saved_games.yaml', 'a'){|f| f.write(YAML.dump(@game))}
      @status = 'quit'
    end

    def show_saved_games
      @status = 'load'
      load_prompt
      i = 0
      YAML.load_stream(File.open('./saved_games.yaml', 'r')).each do |game|
        print "#{i += 1}: "
        print game.show_word
        print "(#{game.turns} turns left)"
        print "\n"
      end
    end

    def load_game(input)
      game_id = 0
      YAML.load_stream(File.open('./saved_games.yaml', 'r')).each do |game|
        game_id += 1
        @game = game
      end
      @status = 'play'
      @game.status = 'play'
      @game.check_game
    end

    def quit_game(input=nil)
      if input.nil? then @status = 'quit'
      elsif input == 's' || 'save' then save_game
      elsif input == 'q' || 'quit' then quit_game
      else invalid_prompt
      end
    end

    def loop
      repl = lambda do |prompt|
        print prompt
        process(gets.chomp!)
      end
      repl['% Hangman-0.1.0: '] while @status != 'quit'
      thanks_prompt
    end
  end
end