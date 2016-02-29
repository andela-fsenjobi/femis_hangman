require 'spec_helper'

describe FemisHangman::Game do
  context "when creating a game with difficulty level 'advanced' and feedback mode 'funny'" do
    subject {FemisHangman::Game.new(3, 2)}
    context "when displaying the history of the game" do
      it 'should have an empty history' do
        expect(subject.history).to eq([])
      end

      it 'should have 10 turns by default' do
        expect(subject.turns).to eq(10)
      end

      it 'should gave a default game status of play' do
        expect(subject.status).to eq('play')
      end

      it 'should have the same feedback as that supplied' do
        expect(subject.feedback).to eq(2)
      end

      it 'should have a word length of at least 12' do
        expect(subject.word.length).to be > 12
      end
  end

    context "when creating a game with difficulty level 'intermediate' and feedback mode 'funny'" do
      subject {FemisHangman::Game.new(2, 2)}
      it 'should have a word length of at least 9' do
        expect(subject.word.length).to be > 8
      end

      it 'should have a word length of at most 12' do
        expect(subject.word.length).to be <= 12
      end
    end

    context 'when including an existing letter into game history' do
      game = FemisHangman::Game.new(2,2)
      game.history = ["a", "b", "c"]
      subject {game.include_letter("a", ["a", "b", "c"])}
      it 'should return the exact array is history already contains the letter' do
        expect(subject).to eq(["a", "b", "c"])
      end
    end

    context 'when including a new letter into game history' do
      game = FemisHangman::Game.new(2,2)
      game.history = ["b", "c"]
      subject {game.include_letter("a", game.history)}
      it 'should return an array that now contains the included letter' do
        expect(subject).to eq(["b", "c", "a"])
      end
    end

    context 'when displaying a word during the game' do
      game = FemisHangman::Game.new(2,2)
      game.history = ['a', 'b', 'c']
      game.word = 'elenor'
      it 'hides the letter if it is not included in player history' do
        expect(game.show_word).to eq('_ _ _ _ _ _ ')
      end
    end

    context 'when displaying a word contained in the player history' do
      game = FemisHangman::Game.new(2,2)
      game.history = ['a', 'b', 'c']
      game.word = 'abacus'
      it 'should show only words contained in hte player history' do
        expect(game.show_word).to eq('a b a c _ _ ')
      end

      it 'should not have been won' do
        expect(game.won?).to be false
      end

      it 'should not have been lost' do
        expect(game.lost?).to be false
      end
    end

    context 'when printing current game status' do
      game = FemisHangman::Game.new(2,2)
      game.history = ['a', 'b', 'c', 'u', 'j', 's']
      game.word = 'abacus'
      it 'should print all words contained in the player history' do
        expect(game.show_word).to eq('a b a c u s ')
      end

      it 'should display all letters in the history' do
        expect(game.game_history).to eq('a b c u j s ')
      end

      it 'should have won the game' do
        expect(game.won?).to be true
      end

      it 'should not have lost the game' do
        expect(game.lost?).to be false
      end
    end

    context 'Show output' do
      game = FemisHangman::Game.new(2,2)
      game.turns = 0
      context "Check if game is won" do
        it { expect(game.won?).to be false }
      end
      context "Check if game is lost" do
        it { expect(game.lost?).to be true }
      end
    end

    it 'Should change the status of a game when lost' do
      game = FemisHangman::Game.new(2,2)
      game.game_won
      expect(game.status).to eq('restart')
    end

    it 'Should change the status of a game when won' do
      game = FemisHangman::Game.new(2,2)
      game.game_lost
      expect(game.status).to eq('restart')
    end

    it 'Should change the status of a when quitted' do
      game = FemisHangman::Game.new(2,2)
      game.quit_game
      expect(game.status).to eq('quit')
    end
  end
end
