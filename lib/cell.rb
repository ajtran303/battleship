class Cell

  attr_reader :coordinate,
              :ship

  def initialize(coordinate)
    @coordinate = coordinate
    @ship = nil
    @is_fired_upon = false
  end

  def empty?
    @ship == nil
  end

  def place_ship(ship)
    @ship = ship
  end

  def fire_upon
    @is_fired_upon = true
    if !empty?
      @ship.hit
    end
  end

  def render(reveal=false)
    if !empty? && fired_upon? && @ship.sunk?
      "X"
    elsif !empty? && fired_upon?
      "H"
    elsif !empty? && !fired_upon? && reveal == true
      "S"
    elsif empty? && fired_upon?
      "M"
    elsif !fired_upon?
      "."
    end
  end

  def fired_upon?
    @is_fired_upon
  end

end
