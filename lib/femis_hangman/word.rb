module FemisHangman
  class Word
    def generate(difficulty)
      file = File.open('./dictionary.txt', 'r')
      rand(41211).times { file.gets }
      word = clean_word($_)
      file.close
      if confirm(difficulty, word) then word
      else generate(difficulty)
      end
    end

    def confirm(difficulty, word)
      if word.length > 4 * difficulty && word.length <= 4 * (difficulty + 1)
        true
      else
        false
      end
    end

    def clean_word(word)
      word.delete("\n")
    end
  end
end