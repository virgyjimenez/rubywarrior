class Player
  def play_turn(warrior)

    if warrior.feel.wall?
      warrior.pivot!
    elsif warrior.feel(:forward).empty?
      if warrior_health(warrior) && warrior.health < 12
        warrior.walk!(:backward)
      elsif warrior.health < 20 && warrior.feel(:backward).wall?
        warrior.rest!
      else
        warrior.walk!(:forward)
      end
    else
      warrior.attack!(:forward)
    end
    @health = warrior.health
  end

  def warrior_health(warrior)
    @health = warrior.health if @health.nil?
    warrior.health < @health
  end

  def rest?(warrior)
    warrior_health(warrior) && warrior.feel.empty?
  end

  def captive?(warrior)
    if warrior.feel.captive?
      warrior.rescue!
    else
      warrior.attack!
    end
  end
end
