require 'spec_helper'

describe FemisHangman::Word do
  context "When creating an object of the class 'Word'" do
    subject {FemisHangman::Word.new}
    it { expect(subject).to be_instance_of FemisHangman::Word }
  end

  context "When generating a word based on difficulty level" do
    it { expect(subject.generate(1).length).to be >= 4 }
    it { expect(subject.generate(1).length).to be <= 8 }
    it { expect(subject.generate(2).length).to be > 8 }
    it { expect(subject.generate(2).length).to be <= 12 }
    it { expect(subject.generate(3).length).to be > 12 }
  end

  context "When confirming the length of a gnerated word" do
    it { expect(subject.confirm(3, "word")).to be false}
    it { expect(subject.confirm(3, "eleventh")).to be false}
    it { expect(subject.confirm(2, "twenty-twenty")).to be false}
    it { expect(subject.confirm(3, "twenty-twenty")).to be true}
    it { expect(subject.confirm(2, "twentieth")).to be true}
    it { expect(subject.confirm(1, "words")).to be true}
    it { expect(subject.confirm(1, "the")).to be false}
  end

  context "Remove new line character from text" do
    it { expect(subject.clean_word("word\n")).to eq("word") }
    it { expect(subject.clean_word("word")).to eq("word") }
  end
end