require 'spec_helper'

describe FemisHangman::Router do
  context '.new' do
    before :each do
      subject {FemisHangman::Router.new {}}
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

    it {should respond_to(:welcome_prompt)}
    it {should respond_to(:invalid_prompt)}
    it {should respond_to(:load_prompt)}
    it {should respond_to(:begin_prompt)}

    it {should respond_to(:size_prompt)}
    it {should respond_to(:instructions_prompt)}
    it {should respond_to(:save_prompt)}
    it {should respond_to(:lost_prompt)}

    it {should respond_to(:won_prompt)}
    it {should respond_to(:lost_gui)}
    it {should respond_to(:won_gui)}
    it {should respond_to(:level_prompt)}

    it {should respond_to(:feedback_prompt)}
    it {should respond_to(:replay_prompt)}
    it {should respond_to(:empty_prompt)}
    it {should respond_to(:duplicate_prompt)}

    it {should respond_to(:turns_prompt)}
    it {should respond_to(:print_text)}
    it {should respond_to(:thanks_prompt)}
    it {should respond_to(:game_instruction_prompt)}
  end
  # context 'print out messages' do
  #   it "should Print out a welcome message" do
  #     expect(subject.welcome_prompt).to output('Welcome to Hangman. Guess right or get hanged!').to_stdout
  #   end
  # end
end