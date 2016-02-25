require 'router'

describe Word do
  context '.new(3, 2)' do
    subject {Game.new(3, 2)}
    context "Word" do
      it { expect(subject.history).to eq([]) }
    end

    context "Game turns" do
      it { expect(subject.turns).to eq(10) }
    end

    context "Game status" do
      it { expect(subject.status).to eq('play') }
    end

    context "Game feedback mode" do
      it { expect(subject.feedback).to eq(2) }
    end

    context "Game word length" do
      it { expect(subject.word.length).to be > 12 }
    end
  end

  context '.new(2, 2)' do
    subject {Game.new(2, 2)}
    context "Game word length" do
      it { expect(subject.word.length).to be > 8 }
    end

    context "Game word length" do
      it { expect(subject.word.length).to be <= 12 }
    end
  end

  context 'include_letter("a", ["a", "b", "c"])' do
    game = Game.new(2,2)
    game.history = ["a", "b", "c"]
    subject {game.include_letter("a", ["a", "b", "c"])}
    context "Game include letter" do
      it { expect(subject).to eq(["a", "b", "c"]) }
    end
  end

  context 'include_letter("a", ["b", "c"])' do
    game = Game.new(2,2)
    game.history = ["b", "c"]
    subject {game.include_letter("a", game.history)}
    context "Game include letter" do
      it { expect(subject).to eq(["b", "c", "a"]) }
    end
  end

  context 'Show output' do
    game = Game.new(2,2)
    game.history = ['a', 'b', 'c']
    game.word = 'elenor'
    context "Game include letter" do
      it { expect(game.show_word).to eq('_ _ _ _ _ _ ') }
    end
  end

  context 'Show output' do
    game = Game.new(2,2)
    game.history = ['a', 'b', 'c']
    game.word = 'abacus'
    context "Print current game status" do
      it { expect(game.show_word).to eq('a b a c _ _ ') }
    end
    context "Check if game is won" do
      it { expect(game.won?).to be false }
    end
    context "Check if game is lost" do
      it { expect(game.lost?).to be false }
    end
  end

  context 'Show output' do
    game = Game.new(2,2)
    game.history = ['a', 'b', 'c', 'u', 'j', 's']
    game.word = 'abacus'
    context "Print current game status" do
      it { expect(game.show_word).to eq('a b a c u s ') }
    end
    context "Print current game history" do
      it { expect(game.game_history).to eq('a b c u j s ') }
    end
    context "Check if game is won" do
      it { expect(game.won?).to be true }
    end
    context "Check if game is lost" do
      it { expect(game.lost?).to be false }
    end
  end

  context 'Show output' do
    game = Game.new(2,2)
    game.turns = 0
    context "Check if game is won" do
      it { expect(game.won?).to be false }
    end
    context "Check if game is lost" do
      it { expect(game.lost?).to be true }
    end
  end
end