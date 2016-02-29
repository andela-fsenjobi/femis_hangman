require 'spec_helper'

describe FemisHangman::Word do
  context "When creating an object of the class 'Word'" do
    subject {FemisHangman::Word.new}
    it { expect(subject).to be_instance_of FemisHangman::Word }
  end

  context "When generating a word based on difficulty level" do
    it 'should generate a word that is at least 4 characters long for beginner' do
      expect(subject.generate(1).length).to be >= 4
    end

    it 'should generate a word that is at most 8 characters long for beginner' do
      expect(subject.generate(1).length).to be <= 8
    end
    it 'should generate a word that is at least 9 characters long for intermediate' do
      expect(subject.generate(2).length).to be > 8
    end
    it 'should generate a word that is at most 12 characters long for beginner' do
      expect(subject.generate(2).length).to be <= 12
    end
    it 'should generate a word that is at least 12 characters long for beginner' do
      expect(subject.generate(3).length).to be > 12
    end
  end

  context 'When confirming the length of a generated word' do
    it 'should not accept a four letter word as difficult' do
      expect(subject.confirm(3, "word")).to be false
    end

    it 'should not accept an eight letter word as difficult' do
      expect(subject.confirm(3, "eleventh")).to be false
    end

    it 'should not accept a 13 letter word as intermediate' do
      expect(subject.confirm(2, "twenty-twenty")).to be false
    end

    it 'should accept a 13 letter word as difficult' do
      expect(subject.confirm(3, "twenty-twenty")).to be true
    end

    it 'should accept a 9 letter word as intermediate' do
      expect(subject.confirm(2, "twentieth")).to be true
    end

    it 'should accept a 5 letter word as beginner' do
      expect(subject.confirm(1, "words")).to be true
    end

    it 'should not accept a 3 letter word as beginner' do
      expect(subject.confirm(1, "the")).to be false
    end
  end

  context "When removing new line character from text" do
    it "should remove '\\n\' from a given text" do
      expect(subject.clean_word("word\n")).to eq("word")
    end

    it "should leave a text without new line character intact" do
      expect(subject.clean_word("word")).to eq("word")
    end
  end
end