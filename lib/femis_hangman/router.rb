require 'word'
require 'message'
require 'word'
require 'game'
require 'YAML'

module Hangman
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
      elsif @status == 'finish' then finish_game(input)
      elsif @status == 'save' then save_game
      elsif @status == 'load' then load_game(input)
      elsif @status == 'quit' || 'end' then quit_game
      else
        welcome(input)
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

    def choose_feedback(input)
      @feedback = input.to_i
      if @feedback < 1 || @feedback > 2
        feedback_prompt
        return
      end
      level_prompt
      @status = 'start'
    end

    def begin_game(input)
      @difficulty = input.to_i
      if @difficulty < 1 || @difficulty > 3
        invalid_prompt
        return
      end
      @status = 'play'
      create_game
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
        if input == 'r' || input == 'restart'
          level_prompt
          @status = 'start'
        elsif input == 'q' || input == 'quit'
          quit_game
        else invalid_prompt
        end
      elsif @game.status == 'quit'
        if input == 's' || 'save' then save_game
        elsif input == 'q' || 'quit' then quit_game
        else
          invalid_prompt
        end
      else @game.control(input)
      end
    end

    def start_game
      @status = 'feedback'
      welcome_prompt
      feedback_prompt
    end

    def finish_game(input)
      if input == 'r' || 'restart'
        @status = 'start'
        begin_game(input)
      elsif input == 'q' || 'quit'
        save_prompt
        @status = 'save'
      else
        invalid_prompt
      end
    end

    def save_game
      File.open('./saved_games.yaml', 'a'){|f| f.write(YAML.dump(@game))}
      thanks_prompt
      @status = 'end'
    end

    def show_saved_games
      @status = 'load'
      load_prompt
      i = 0
      YAML.load_stream(File.open('./saved_games.yaml', 'r')).each do |game|
        print "#{i += 1}: "
        word = game.word.split('')
        history = game.history
        word.each do |letter|
          if history.include?(letter)
            print "#{letter} "
          else
            print '_ '
          end
        end
        print "(#{game.turns} turns left)"
        print "\n"
      end
    end

    def load_game(input)
      game_id = input.to_i
      i = 0
      YAML.load_stream(File.open('./saved_games.yaml', 'r')).each do |game|
        i += 1
        if i == game_id
          @status = 'play'
          @game = game
          @game.status = 'play'
          @game.check_game
        end
      end
    end

    def quit_game
      @status = 'end'
      thanks_prompt
    end

    def loop
      repl = lambda do |prompt|
        print prompt
        process(gets.chomp!)
      end

      repl["% Hangman-0.1.0: "] while @status != 'end'
    end
  end
end