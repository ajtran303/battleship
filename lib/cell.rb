class Cell
  attr_reader :coordinate,
              :ship

  def initialize(coordinate)
    @coordinate = coordinate
    @ship = nil
    @fired_upon = false
  end

  def empty?
    @ship == nil
  end

  def place_ship(ship_obj)
    @ship = ship_obj
  end

  def fire_upon
    @fired_upon = true
  end


  def render(reveal=false)
    if reveal == true && !empty?
      "S"
    elsif reveal == true || fired_upon? && @ship == nil
      "M"
    else
      "."
    end
  end

  def fired_upon?
    @fired_upon
  end
# ”.” if the cell has not been fired upon.
# “M” if the cell has been fired upon and it does not contain a ship (the shot was a miss).
# “H” if the cell has been fired upon and it contains a ship (the shot was a hit).
# “X” if the cell has been fired upon and its ship has been sunk.


end
