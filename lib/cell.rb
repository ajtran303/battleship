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

  def place_ship(ship_obj)
    @ship = ship_obj
  end

  def fire_upon
    @is_fired_upon = true
    if !empty?
      @ship.hit
    end
  end

  # “X” if the cell has been fired upon and its ship has been sunk.

  def render(reveal=nil)
    if !empty? && fired_upon? && @ship.sunk? || (!empty? && fired_upon? && @ship.sunk?) && reveal == true
      "X"
    elsif !empty? && fired_upon? || (!empty? && fired_upon?) && reveal == true
      "H"
    elsif !empty? && reveal == true
      "S"
    elsif empty? && fired_upon? || reveal == true
      "M"
    elsif !fired_upon?
      "."
    end
  end

  def fired_upon?
    @is_fired_upon
  end

end
