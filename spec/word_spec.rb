require 'spec_helper'

describe FemisHangman::Word do
  describe '#generate' do
    context 'when beginner' do
      it { expect(subject.generate(1).length).to be >= 4 }
      it { expect(subject.generate(1).length).to be <= 8 }
    end

    context 'when intermediate' do
      it { expect(subject.generate(2).length).to be >= 9 }
      it { expect(subject.generate(2).length).to be <= 12 }
    end

    context 'when advanced' do
      it { expect(subject.generate(3).length).to be >= 13 }
    end
  end

  describe '#confirm' do
    context 'when beginner' do
      it { expect(subject.confirm(1, "the")).to be false }
      it { expect(subject.confirm(1, "words")).to be true }
    end

    context 'when intermediate' do
      it { expect(subject.confirm(2, "twenty-twenty")).to be false }
      it { expect(subject.confirm(2, "twentieth")).to be true }
    end

    context 'when advanced' do
      it { expect(subject.confirm(3, "word")).to be false }
      it { expect(subject.confirm(3, "twenty-twenty")).to be true }
    end
  end

  describe '#clean_word' do
    it { expect(subject.clean_word("word\n")).to eq("word") }
    it { expect(subject.clean_word("word")).to eq("word") }
  end
end
