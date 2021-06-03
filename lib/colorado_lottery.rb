class ColoradoLottery
  attr_reader :registered_contestants,
              :winners,
              :current_contestants

  def initialize
    @registered_contestants = Hash.new
    @winners = []
    @current_contestants = Hash.new
  end

  def interested_and_18?(contestant, game)
    if contestant.age >= 18 && contestant.game_interests.include?(game.name)
      true
    else
      false
    end
  end

  def can_register?(contestant, game)
    if interested_and_18?(contestant, game) == true
      true
    else
      false
    end
  end
end