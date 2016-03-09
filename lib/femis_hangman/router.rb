module FemisHangman
  class Router
    include Message
    attr_accessor :status, :difficulty, :feedback, :route

    def initialize
      @status = Status.new
      @route = Route.new(@status)
    end

    def process(input)
      if @status.value == 'welcome' || @status.value == 'save'
        return send("#{@status.value}", input)
      end
      @route.send("#{@status.value}", input)
    end

    def welcome(input)
      route_method = {
          p: :start, play: :start,
          q: :quit, quit: :quit,
          l: :saved_games, load: :saved_games,
          i: :show_instructions, instructions: :show_instructions,
          invalid: :show_invalid
      }
      key = input.to_sym
      key = :invalid unless route_method.has_key? key
      send(route_method[key])
    end

    def start
      puts welcome_prompt
      puts feedback_prompt
      @status.value = 'feedback'
    end

    def save(input=nil)
      if input.nil? || input == 'q' || input == 'quit' then quit
      elsif input == 's' || input == 'save' then @route.save
      else puts invalid_prompt
      end
    end

    def quit
      @status.value = 'quit'
    end

    def saved_games
      puts load_prompt
      @status.value = 'load'
      Memory.new.list.each {|value| puts value }
    end

    def show_instructions
      puts instructions_prompt
    end

    def show_invalid
      puts invalid_prompt
    end
  end
end
