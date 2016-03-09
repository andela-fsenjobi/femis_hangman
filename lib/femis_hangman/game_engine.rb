module FemisHangman
  class GameEngine
    include Message
    attr_accessor :game

    def initialize (game, status)
      @game = game
      @status = status
    end

    def control(input)
      if input.size > 1
        commands(input)
      elsif input.size == 1
        @game.play(input) unless already_used?(input)
        check
      else
        puts invalid_prompt
      end
    end

    def commands(input)
      case input
        when ':h', 'history' then puts @game.history
        when ':q', 'quit' then @game.quit
        else puts invalid_prompt
      end
    end

    def already_used?(input)
      @game.used_letters.include?(input)
    end

    def check
      @game
      if @game.won? then won
      elsif @game.lost? then lost
      else
        puts turns_prompt(@game.turns)
        puts @game.show
      end
    end

    def save
      Memory.new.save(@game)
      @status.value = 'quit'
    end

    def won
      if @game.feedback == 2
        puts won_gui(@game.word)
      else
        puts won_prompt(@game.word)
      end
      @status.value = 'restart'
      puts replay_prompt
    end

    def lost
      if @game.feedback == 2
        puts lost_gui(@game.word)
      else
        puts lost_prompt(@game.word)
      end
      @status.value = 'restart'
      puts replay_prompt
    end
  end
end