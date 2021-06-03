require 'rspec'
require './lib/game'
require './lib/contestant'

RSpec.describe Contestant do
  before :each do
    @alexander = Contestant.new({first_name: 'Alexander',
                                 last_name: 'Aigiades',
                                 age: 28,
                                 state_of_residence: 'CO',
                                 spending_money: 10})
  end

  it 'exists' do
    expect(@alexander).to be_a(Contestant)
  end

  it 'initializes with attributes' do
    expect(@alexander.first_name).to eq('Alexander')
    expect(@alexander.last_name).to eq('Aigiades')
    expect(@alexander.full_name).to eq('Alexander Aigiades')
    expect(@alexander.age).to eq(28)
    expect(@alexander.state_of_residence).to eq('CO')
    expect(@alexander.spending_money).to eq(10)
    expect(@alexander.game_interests).to eq([])
  end

  it 'can determine if the contestant is out of state' do
    expect(@alexander.out_of_state?).to eq(false)
  end

  it 'starts with no game interests' do
    expect(@alexander.game_interests).to eq([])
  end

  xit 'can add game interests' do
    @alexander.add_game_interest('Mega Millions')
    @alexander.add_game_interest('Pick 4')

    expect(@alexander.game_interests).to eq(['Mega Millions', 'Pick 4'])
  end
end
