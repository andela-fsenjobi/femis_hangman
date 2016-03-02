require 'spec_helper'

describe FemisHangman::Router do
  before :each do
    subject {FemisHangman::Router.new {}}
    allow(subject).to receive(:puts).and_return(nil)
  end

  context 'When the game starts' do
    it { expect(subject).to be_instance_of FemisHangman::Router }
    it { expect(subject.status).to eq('begin') }
  end

  context 'when the router receives an input in the begin state' do
    it 'should redirect to welcome if the user just started' do
      allow(subject).to receive(:puts).and_return(nil)
      allow(subject.process('p')).to receive(:welcome)
      expect(subject.status).to eq('feedback')
    end

    it 'should redirect to show_saved_games if the user wants to see saved games' do
      allow(subject).to receive(:puts).and_return(nil)
      allow(subject.process('l')).to receive(:load_game)
      expect(subject.status).to eq('load')
    end

    it 'should redirect leave the status unchanged if the user views instructions' do
      allow(subject).to receive(:puts).and_return(nil)
      allow(subject.process('i')).to receive(:welcome)
      expect(subject.status).to eq('begin')
    end

    it 'should redirect to quit if user quits when game starts' do
      allow(subject).to receive(:puts).and_return(nil)
      expect(subject.welcome('q')).to eq('quit')
    end
  end

  context 'when the router receives an input in the feedback state' do
    it 'should redirect to choose difficulty level' do
      subject.status = 'feedback'
      allow(subject).to receive(:puts).and_return(nil)
      allow(subject.process('1')).to receive(:choose_feedback)
      expect(subject.status).to eq('start')
    end

    it 'should retain the feedback status' do
      subject.status = 'feedback'
      allow(subject).to receive(:puts).and_return(nil)
      allow(subject.process('l')).to receive(:choose_feedback)
      expect(subject.status).to eq('feedback')
    end
  end

  context 'when the router receives an input in the start state' do
    it 'should redirect to play' do
      subject.status = 'start'
      allow(subject).to receive(:puts).and_return(nil)
      allow(subject.process('2')).to receive(:begin_game)
      expect(subject.status).to eq('play')
    end

    it 'should retain the start status' do
      subject.status = 'start'
      allow(subject).to receive(:puts).and_return(nil)
      allow(subject.process('l')).to receive(:begin_game)
      expect(subject.status).to eq('start')
    end
  end

  context 'when the router receives an input in the play state' do
    it 'should remain in play' do
      subject.status = 'start'
      allow(subject).to receive(:puts).and_return(nil)
      allow(subject.process('2')).to receive(:play)
      expect(subject.status).to eq('play')
    end
  end

  context 'when the router receives a valid input in the restart state' do
    it 'should take the game back to start mode' do
      subject.status = 'finish'
      allow(subject).to receive(:puts).and_return(nil)
      allow(subject.process('r')).to receive(:finish_game)
      expect(subject.status).to eq('start')
    end

    it 'should take the game to quit mode' do
      subject.status = 'finish'
      allow(subject).to receive(:puts).and_return(nil)
      allow(subject.process('q')).to receive(:finish_game)
      expect(subject.status).to eq('quit')
    end
  end

  context 'when the router receives an invalid input in the restart state' do
    it 'should take the game back to start mode' do
      subject.status = 'finish'
      allow(subject).to receive(:puts).and_return(nil)
      allow(subject.process('j')).to receive(:finish_game)
      expect(subject.status).to eq('finish')
    end
  end

  context 'when the router receives an input in the begin state' do
    it 'should prompt user for feedback' do
      allow(subject).to receive(:puts).and_return(nil)
      allow(subject.welcome('p')).to receive(:start_game)
      expect(subject.status).to eq('feedback')
    end

    it 'should prompt user to select a saved game' do
      allow(subject).to receive(:puts).and_return(nil)
      allow(subject.welcome('l')).to receive(:load_game)
      expect(subject.status).to eq('load')
    end

    it 'should show user the game instructions' do
      allow(subject).to receive(:puts).and_return(nil)
      allow(subject.welcome('i')).to receive(:instructions_prompt)
      expect(subject.status).to eq('begin')
    end

    it 'should quit the game' do
      allow(subject).to receive(:puts).and_return(nil)
      allow(subject.welcome('q')).to receive(:quit_game)
      expect(subject.status).to eq('quit')
    end
  end

  context 'When the play option is selected' do
    it "Sets status of the router to 'feedback'" do
      subject.start_game
      expect(subject.status).to eq('feedback')
    end
  end

  context 'when the boring feedback mode selected' do
    it 'should set feedback mode to boring' do
      subject.choose_feedback('1')
      expect(subject.feedback).to eq(1)
    end

    it "should set router status to 'start'" do
      subject.choose_feedback('1')
      expect(subject.status).to eq('start')
    end
  end

  context 'when the funny feedback mode selected' do
    it "should set feedback mode to funny" do
      subject.choose_feedback('2')
      expect(subject.feedback).to eq(2)
    end

    it "should set router status to 'start'" do
      subject.choose_feedback('2')
      expect(subject.status).to eq('start')
    end
  end

  context 'when an invalid feedback mode is selected' do
    it "should leave the feedback mode unset" do
      subject.choose_feedback('3')
      expect(subject.feedback).to be nil
    end

    it "should leave the router status at 'begin'" do
      subject.choose_feedback('3')
      expect(subject.status).to eq('begin')
    end
  end

  context "when difficulty level 'advanced' is selected" do
    it 'should set the difficulty level to difficult' do
      subject.begin_game('3')
      expect(subject.feedback).to be nil
    end

    it "should set the router status to 'play'" do
      subject.begin_game('3')
      expect(subject.status).to eq('play')
    end
  end

  context "when difficulty level 'intermediate' is selected" do
    it 'should set the difficulty level to intermediate' do
      subject.begin_game('2')
      expect(subject.difficulty).to eq(2)
    end

    it "should set the router status to 'play'" do
      subject.begin_game('2')
      expect(subject.status).to eq('play')
    end
  end

  context "when difficulty level 'beginner' is selected" do
    it 'should set the difficulty level to beginner' do
      subject.begin_game('1')
      expect(subject.difficulty).to eq(1)
    end

    it "should set the router status to 'play'" do
      subject.begin_game('1')
      expect(subject.status).to eq('play')
    end
  end

  context 'when an invalid difficulty level is selected' do
    it 'should leave the difficulty level unset' do
      subject.begin_game('5')
      expect(subject.difficulty).to be nil
    end

    it "should leave the router status at 'begin'" do
      subject.begin_game('5')
      expect(subject.status).to eq('begin')
    end
  end

  context 'when a game is being created' do
    it 'should be an instance of the Game class' do
      subject.choose_feedback(2)
      subject.begin_game('3')
      subject.create_game
      expect(subject.game).to be_a(FemisHangman::Game)
      expect(subject.difficulty).to eq(3)
    end

    it "should change the router status to 'play'" do
      subject.choose_feedback(2)
      subject.begin_game('3')
      subject.create_game
      expect(subject.game).to be_a(FemisHangman::Game)
      expect(subject.game.status).to eq('play')
    end
  end

  context 'when the restart option is selected' do
    it 'should change the status of the game to restart' do
      subject.restart_game('r')
      expect(subject.status).to eq('start')
      subject.restart_game('restart')
      expect(subject.status).to eq('start')
    end
  end

  context 'when the quit option is selected' do
    it 'Should change the status of the game to restart' do
      subject.restart_game('q')
      expect(subject.status).to eq('quit')
      subject.restart_game('quit')
      expect(subject.status).to eq('quit')
    end
  end

  context 'when router is in the restart mode and an invalid input is supplied' do
    it 'Should change the status of the game to restart' do
      subject.status = 'finish'
      subject.restart_game('zz')
      expect(subject.status).to eq('finish')
    end
  end

  context 'when a list of saved games is requested' do
    it 'should change the staus of the game to load' do
      subject.show_saved_games
      expect(subject.status).to eq('load')
    end
  end

  context 'when the save option is selected' do
    it 'should save the game and quit the game' do
      subject.save_game('./save_test_games.yaml')
      expect(subject.status).to eq('quit')
    end
  end

  context 'when the quit option is selected' do
    it 'should quit the game' do
      subject.quit_game
      expect(subject.status).to eq('quit')
    end

    it 'should save then quit the game' do
      subject.quit_game('s')
      allow(subject).to receive(:save_game){ './save_test_games.yaml' }
      expect(subject.status).to eq('quit')
    end
  end

  context 'when loading a saved game' do
    it 'should resume the saved game' do
      subject.load_game('1')
      expect(subject.game).to be_a FemisHangman::Game
    end

    it 'should have a current word' do
      subject.load_game('1')
      expect(subject.game.word).not_to be nil
    end

    it 'should have a game history' do
      subject.load_game('1')
      expect(subject.game.history).to be_an Array
    end

    it 'should have a number of turns' do
      subject.load_game('1')
      expect(subject.game.turns).to be_a Fixnum
    end

    it 'should set the router status to play' do
      subject.load_game('1')
      expect(subject.game.status).to eq('play')
    end

    it 'should have a valid feedback mode' do
      subject.load_game('1')
      expect(subject.game.feedback).to be_a Fixnum
      expect(subject.game.feedback).to be > 0
      expect(subject.game.feedback).to be <= 2
    end
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

  it {should respond_to(:restart_game)}
  it {should respond_to(:save_game)}
  it {should respond_to(:show_saved_games)}
  it {should respond_to(:saved_games_list)}

  it {should respond_to(:load_game)}
  it {should respond_to(:resume_game)}
  it {should respond_to(:quit_game)}
  it {should respond_to(:loop)}

  it {should respond_to(:process)}
  it {should respond_to(:welcome)}
end