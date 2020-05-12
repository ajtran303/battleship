require 'minitest/autorun'
require 'minitest/pride'
require './lib/ship'

class ShipTest < Minitest::Test

def test_ship_exists_and_holds_attributes
  cruiser = Ship.new("Cruiser", 3)
  assert_equal "Cruiser", cruiser.name
  assert_equal 3, cruiser.name
  assert_equal 3, cruiser.health
end

end
