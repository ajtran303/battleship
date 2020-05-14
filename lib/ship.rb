#Here's a zoom link https://zoom.us/j/5752468064?pwd=dE1YcVN6THFReW1MWWlTamU3eVZ5Zz09
#hop on.  Cheers!

class Ship

  attr_reader :name,
              :length,
              :health

  def initialize(name, length)
    @name = name
    @length = length
    @health = length
  end

  def sunk?
    @health == 0
  end

  def hit
    @health -= 1
  end

end
