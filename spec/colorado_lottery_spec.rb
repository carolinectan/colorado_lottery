require 'rspec'
require './lib/game'
require './lib/contestant'
require "./lib/colorado_lottery"

RSpec.describe ColoradoLottery do
  before :each do
    @lottery = ColoradoLottery.new

    @pick_4 = Game.new('Pick 4', 2)
    @mega_millions = Game.new('Mega Millions', 5, true)
    @cash_5 = Game.new('Cash 5', 1)

    @alexander = Contestant.new({ first_name: 'Alexander',
                                  last_name: 'Aigades',
                                  age: 28,
                                  state_of_residence: 'CO',
                                  spending_money: 10})
    @benjamin = Contestant.new({  first_name: 'Benjamin',
                                  last_name: 'Franklin',
                                  age: 17,
                                  state_of_residence: 'PA',
                                  spending_money: 100})
    @frederick = Contestant.new({ first_name:  'Frederick',
                                  last_name: 'Douglas',
                                  age: 55,
                                  state_of_residence: 'NY',
                                  spending_money: 20})
    @winston = Contestant.new({   first_name: 'Winston',
                                  last_name: 'Churchill',
                                  age: 18,
                                  state_of_residence: 'CO',
                                  spending_money: 5})
    @alexander.add_game_interest('Pick 4')
    @alexander.add_game_interest('Mega Millions')
    @frederick.add_game_interest('Mega Millions')
    @winston.add_game_interest('Cash 5')
    @winston.add_game_interest('Mega Millions')
    @benjamin.add_game_interest('Mega Millions')
  end

  it 'exists' do
    expect(@lottery).to be_a(ColoradoLottery)
  end

  it 'initializes with attributes' do
    expect(@lottery.registered_contestants).to eq({})
    expect(@lottery.winners).to eq([])
    expect(@lottery.current_contestants).to eq({})
  end

  it 'can determine if a contestant is interested and 18' do
    expect(@lottery.interested_and_18?(@alexander, @pick_4)).to eq(true)
    expect(@lottery.interested_and_18?(@benjamin, @mega_millions)).to eq(false)
    expect(@lottery.interested_and_18?(@alexander, @cash_5)).to eq(false)
  end

  it 'can determine if a contestant is eligible to register' do
    expect(@lottery.can_register?(@alexander, @pick_4)).to eq(true)
    expect(@lottery.can_register?(@alexander, @cash_5)).to eq(false)
    expect(@lottery.can_register?(@frederick, @mega_millions)).to eq(true)
    expect(@lottery.can_register?(@benjamin, @mega_millions)).to eq(false)
    expect(@lottery.can_register?(@frederick, @cash_5)).to eq(false)
  end

it 'can register contestants' do
    @lottery.register_contestant(@alexander, @pick_4)

    expected = {
      "Pick 4" => [@alexander]
    }
    expect(@lottery.registered_contestants).to eq(expected)


    @lottery.register_contestant(@alexander, @mega_millions)

    expected = {
    "Pick 4" => [@alexander],
    "Mega Millions" => [@alexander],
  }
    expect(@lottery.registered_contestants).to eq(expected)


    @lottery.register_contestant(@frederick, @mega_millions)
    @lottery.register_contestant(@winston, @cash_5)
    @lottery.register_contestant(@winston, @mega_millions)

    expected = {
    "Pick 4" => [@alexander],
    "Mega Millions" => [@alexander, @frederick, @winston],
    "Cash 5" => [@winston]
    }
    expect(@lottery.registered_contestants).to eq(expected)

    @grace = Contestant.new({first_name: 'Grace',
                             last_name: 'Hopper',
                             age: 20,
                             state_of_residence: 'CO',
                             spending_money: 20})

    @grace.add_game_interest('Mega Millions')
    @grace.add_game_interest('Cash 5')
    @grace.add_game_interest('Pick 4')

    expect(@grace.game_interests).to eq(['Mega Millions', 'Cash 5', 'Pick 4'])

    @lottery.register_contestant(@grace, @mega_millions)
    @lottery.register_contestant(@grace, @cash_5)
    @lottery.register_contestant(@grace, @pick_4)

    expected = {
    "Pick 4" => [@alexander, @grace],
    "Mega Millions" => [@alexander, @frederick, @winston, @grace],
    "Cash 5" => [@winston, @grace]
    }
    expect(@lottery.registered_contestants).to eq(expected)
  end

  it 'can return eligible contestants' do
    @lottery.register_contestant(@alexander, @pick_4)
    @lottery.register_contestant(@alexander, @mega_millions)
    @lottery.register_contestant(@frederick, @mega_millions)
    @lottery.register_contestant(@winston, @cash_5)
    @lottery.register_contestant(@winston, @mega_millions)

    @grace = Contestant.new({first_name: 'Grace',
                             last_name: 'Hopper',
                             age: 20,
                             state_of_residence: 'CO',
                             spending_money: 20})
    @grace.add_game_interest('Mega Millions')
    @grace.add_game_interest('Cash 5')
    @grace.add_game_interest('Pick 4')

    @lottery.register_contestant(@grace, @mega_millions)
    @lottery.register_contestant(@grace, @cash_5)
    @lottery.register_contestant(@grace, @pick_4)

    expected = {
    "Pick 4" => [@alexander, @grace],
    "Mega Millions" => [@alexander, @frederick, @winston, @grace],
    "Cash 5" => [@winston, @grace]
    }

    expect(@lottery.eligible_contestants(@pick_4)).to eq(expected["Pick 4"])
    expect(@lottery.eligible_contestants(@cash_5)).to eq(expected["Cash 5"])
    expect(@lottery.eligible_contestants(@mega_millions)).to eq(expected["Mega Millions"])
  end
end
