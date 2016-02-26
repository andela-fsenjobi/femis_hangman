require 'spec_helper'

describe FemisHangman::Router do
  context '.new' do
    before :each do
      subject {FemisHangman::Router.new}
    end
    context "FemisHangman::Router" do
      it { expect(subject).to be_instance_of FemisHangman::Router }
      it { expect(subject.status).to eq('begin') }
    end

    it "Sets status of the router class to 'feedback'" do
      subject.start_game
      expect(subject.status).to eq('feedback')
    end

    it "Set feedback mode and changes game status to 'start'" do
      subject.choose_feedback('1')
      expect(subject.feedback).to eq(1)
      expect(subject.status).to eq('start')
    end

    it "Set feedback mode and changes game status to 'start'" do
      subject.choose_feedback('2')
      expect(subject.feedback).to eq(2)
      expect(subject.status).to eq('start')
    end

    it "Set invalid feedback mode" do
      subject.choose_feedback('3')
      expect(subject.feedback).to be nil
      expect(subject.status).to eq('begin')
    end

    it "Choose beginner difficulty level" do
      subject.begin_game('1')
      expect(subject.difficulty).to eq(1)
      expect(subject.status).to eq('play')
    end

    it "Choose advanced difficulty level" do
      subject.begin_game('3')
      expect(subject.difficulty).to eq(3)
      expect(subject.status).to eq('play')
    end

    it "Choose advanced difficulty level" do
      subject.choose_feedback(2)
      subject.begin_game('5')
      expect(subject.difficulty).to be nil
      expect(subject.status).to eq('start')
    end

    it "Create a game" do
      subject.choose_feedback(2)
      subject.begin_game('3')
      subject.create_game
      expect(subject.game).to be_a(FemisHangman::Game)
      expect(subject.game.status).to eq('play')
    end

    it "Should change the status of the game to restart" do
      subject.choose_feedback(2)
      subject.begin_game('3')
      subject.create_game
      subject.restart_game('r')
      expect(subject.status).to eq('start')
      subject.restart_game('restart')
      expect(subject.status).to eq('start')
    end

    it "Should change the status of the game to restart" do
      subject.choose_feedback(2)
      subject.begin_game('3')
      subject.create_game
      subject.restart_game('q')
      expect(subject.status).to eq('quit')
      subject.restart_game('quit')
      expect(subject.status).to eq('quit')
    end
  end
end