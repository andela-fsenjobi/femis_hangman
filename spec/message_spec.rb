require 'spec_helper'

describe Message do
  subject { FemisHangman::Router.new { include Message } }
  it 'should include the length passed' do
    expect(subject.size_prompt(12)).to include('12')
  end

  it 'should print out the size of the word' do
    expect(subject.load_prompt).to include('Press the respective number')
  end

  it 'should supply the prompt to begin the game' do
    expect(subject.begin_prompt).to include('games begin')
  end

  it 'should supply the prompt to begin the game' do
    expect(subject.instructions_prompt).to include("Press 'p' or 'play'")
  end

  it 'should inform the user to save or quit' do
    expect(subject.save_prompt).to include("Press 's' or 'save'")
  end

  it 'should inform the user that he is dead' do
    expect(subject.lost_prompt('information')).to include("You are dead!")
  end

  it 'should include the word' do
    expect(subject.won_prompt('information')).to include('information')
  end

  it 'should inform the the game has been lost' do
    expect(subject.lost_gui('information')).to include('You are dead!')
  end

  it 'should inform the user he is free to go' do
    expect(subject.won_gui('information')).to include('You are free')
  end

  it 'should inform the user to choose a difficulty level' do
    expect(subject.level_prompt).to include('difficulty level')
  end

  it 'should inform the user to choose a feedback type' do
    expect(subject.feedback_prompt).to include('feedback type')
  end

  it 'should inform the user to restart or quit' do
    expect(subject.replay_prompt).to include("Press 'r' or 'restart'")
  end

  it 'should inform the user that the entry is invalid' do
    expect(subject.invalid_prompt).to eq('Invalid entry!')
  end

  it 'should inform the user his history is empty' do
    expect(subject.empty_prompt).to include("haven't used any")
  end

  it 'should inform the user the letter has already been used' do
    expect(subject.duplicate_prompt('a')).to include('a already')
  end

  it 'should inform the user the number of turns he has left' do
    expect(subject.turns_prompt(3)).to include('3 turns left')
  end

  it 'should inform the user the letter has already been used' do
    expect(subject.thanks_prompt).to eq('Thank you for playing!')
  end

  it 'should inform the user the letter has already been used' do
    expect(subject.game_instruction_prompt).to include("Press ':h' or 'history'")
  end

  it 'should inform the user the letter has already been used' do
    expect(subject.invalid_game_prompt).to include("no game with such")
  end
end