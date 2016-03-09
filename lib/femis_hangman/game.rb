module FemisHangman
  class Game
    include Message
    attr_accessor :turns, :used_letters, :word, :feedback, :status

    def initialize(difficulty, feedback, status)
      @word = Word.new.generate(difficulty)
      @used_letters = []
      @turns = 7 + difficulty
      @feedback = feedback
      @status = status
      @status.value = 'play'
    end

    def play(input)
      @turns -= 1 unless @word.include?(input)
      include(input)
    end

    def include(letter)
      @used_letters << letter unless @used_letters.include?(letter)
    end

    def show
      output = ''
      @word.split('').each do |letter|
        if @used_letters.include?(letter)
          output << "#{letter} "
        else
          output << '_ '
        end
      end
      output
    end

    def won?
      length = 0
      @word.split('').each do |val|
        length += 1 if @used_letters.include?(val)
      end
      return true if length == @word.size
      false
    end

    def lost?
      @turns == 0
    end

    def history
      output = ''
      @used_letters.each {|letter| output << "#{letter} "}
      output
    end

    def quit
      @status.value = 'save'
      save_prompt
    end
  end
end
