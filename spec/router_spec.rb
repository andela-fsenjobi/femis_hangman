require 'spec_helper'

describe FemisHangman::Router do
  before :each do
    subject { FemisHangman::Router.new }
    allow(subject).to receive(:puts).and_return(nil)
  end

  context 'When the play option is selected' do
    it "Sets status of the router to 'feedback'" do
      subject.start
      expect(subject.status.value).to eq('feedback')
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
  it {should respond_to(:thanks_prompt)}
  it {should respond_to(:game_instruction_prompt)}

  it {should respond_to(:process)}
  it {should respond_to(:welcome)}
  it {should respond_to(:start)}
  it {should respond_to(:save)}

  it {should respond_to(:quit)}
  it {should respond_to(:saved_games)}
  it {should respond_to(:show_instructions)}
  it {should respond_to(:show_invalid)}
end