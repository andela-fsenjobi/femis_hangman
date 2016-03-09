module FemisHangman
  class Memory
    def save(game, file = './saved_games.yaml')
      File.open(file, 'a'){|f| f.write(YAML.dump(game))}
    end

    def list
      counter = 0
      saved_games = []
      YAML.load_stream(File.open('./saved_games.yaml', 'r')).each do |game|
        counter += 1
        saved_games << item(counter, game)
      end
      saved_games
    end

    def load(input)
      game_id = 0
      YAML.load_stream(File.open('./saved_games.yaml', 'r')).each do |game|
        game_id += 1
        return game if game_id == input.to_i
      end
    end

    def item(counter, game)
      "#{counter}: " + game.show + "(#{game.turns} turns left)"
    end
  end
end
