require 'minitest/autorun'
require 'minitest/pride'
require './lib/ship'

class ShipTest < Minitest::Test

def test_ship_exists_and_holds_attributes
  cruiser = Ship.new("Cruiser", 3)
  assert_equal "Cruiser", cruiser.name
  assert_equal 3, cruiser.length
  assert_equal 3, cruiser.health
end

def test_sunk?
  cruiser = Ship.new("Cruiser", 3)
  assert_equal false, cruiser.sunk?
end

def test_hit
  cruiser = Ship.new("Cruiser", 3)
  cruiser.hit
  assert_equal 2, cruiser.health
end

end
