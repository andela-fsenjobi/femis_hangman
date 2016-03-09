require 'spec_helper'

describe FemisHangman::Game do
  let(:status) {FemisHangman::Status.new}
  subject(:game) {FemisHangman::Game.new(3, 2, status)}
  context 'when difficulty is 3 and feedback, 2' do
    it { expect(game.history).to eq('') }
    it { expect(game.turns).to eq(10) }
    it { expect(game.status.value).to eq('play') }
    it { expect(game.feedback).to eq(2) }
    it { expect(game.word.length).to be > 12 }
  end

  context 'when difficulty is 2 and feedback, 2' do
    subject(:game) {FemisHangman::Game.new(2, 2, status)}
    it { expect(game.history).to eq('') }
    it { expect(game.turns).to eq(9) }
    it { expect(game.status.value).to eq('play') }
    it { expect(game.feedback).to eq(2) }
    it { expect(game.word.length).to be > 8 }
    it { expect(game.word.length).to be <= 12 }
  end

  context 'when difficulty is 1 and feedback, 1' do
    subject(:game) {FemisHangman::Game.new(1, 1, status)}
    it { expect(game.history).to eq('') }
    it { expect(game.turns).to eq(8) }
    it { expect(game.status.value).to eq('play') }
    it { expect(game.feedback).to eq(1) }
    it { expect(game.word.length).to be > 4 }
    it { expect(game.word.length).to be <= 8 }
  end

  describe '#include_letter' do
    context 'when history contains letter' do
      it 'should return the history intact' do
        game.used_letters = ["a", "b", "c"]
        expect(game.include("a")).to eq(@history)
      end
    end

    context 'when history does not contains letter' do
      it 'should append to history' do
        game.used_letters = ["a", "b", "c"]
        expect(game.include("d")).to eq(["a", "b", "c", "d"])
      end
    end
  end

  describe '#show_word' do
    context 'when history contains letter' do
      it 'should show word' do
        game.used_letters = ["a", "b", "c"]
        game.word = 'abacus'
        expect(game.show).to eq('a b a c _ _ ')
      end
    end

    context 'when history contains letter' do
      it 'should show word' do
        game.used_letters = ["a", "b", "c"]
        game.word = 'elenor'
        expect(game.show).to eq('_ _ _ _ _ _ ')
      end
    end
  end

  describe '#won?' do
    context 'when game has not ended' do
      it { expect(game.won?).to be false }
      it { expect(game.lost?).to be false }
    end

    context 'when history contains all letters' do
      it 'should show game won' do
        game.turns = 0
        expect(game.won?).to be false
        expect(game.lost?).to be true
      end
    end

    context 'when game has ended' do
      it 'should win the game' do
        game.used_letters = ['e', 'l', 'n', 'o', 'r']
        game.word = 'elenor'
        expect(game.won?).to be true
        expect(game.lost?).to be false
      end
    end
  end

  describe '#play' do
    context 'when the game class receives an input as guess' do
      it 'should process include letter in game history' do
        expect(game.play('h')).to be_an Array
      end
    end
  end
end