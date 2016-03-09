module FemisHangman
  class Route
    include Message
    attr_accessor :game, :status, :feedback

    def initialize(status)
      @status = status
    end

    def feedback(input)
      if input.to_i < 1 || input.to_i > 2
        puts invalid_prompt
        false
      else
        puts level_prompt
        @feedback = input.to_i
        @status.value = 'start'
      end
    end

    def start(input)
      if input.to_i < 1 || input.to_i > 3
        puts invalid_prompt
      else
        @difficulty = input.to_i
        @status.value = 'play'
        create
      end
    end

    def create
      puts begin_prompt
      @game = Game.new(@difficulty, @feedback, @status)
      @engine = GameEngine.new(@game, @status)
      puts size_prompt(@game.word.size)
      puts turns_prompt(@game.turns)
      puts game_instruction_prompt
      puts (@game.show)
    end

    def play(input)
      puts @engine.control(input)
    end

    def restart(input)
      if input == 'r' || input == 'restart'
        puts level_prompt
        @status.value = 'start'
      elsif input == 'q' || input == 'quit' then @status.value = 'quit'
      else invalid_prompt
      end
    end

    def save
      Memory.new.save(@game)
      @status.value = 'quit'
    end

    def load(input)
      @game ||= Memory.new.load(input)
      @status.value = 'play'
      @engine = GameEngine.new(@game, @status)
      @engine.check
    end
  end
end