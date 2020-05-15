require "./lib/cell"
require "./lib/ship"
require "minitest/autorun"
require "minitest/pride"

class CellTest < MiniTest::Test

  def setup
    @cell = Cell.new("B4")
    @cruiser = Ship.new("Cruiser", 3)
  end

  def test_it_exists
    assert_instance_of Cell, @cell
  end

  def test_it_has_attributes
    assert_equal "B4", @cell.coordinate
    assert_equal nil, @cell.ship
  end

  def test_empty?
    assert_equal true, @cell.empty?
  end

  def test_place_ship
    @cell.place_ship(@cruiser)
    assert_equal @cruiser, @cell.ship
    assert_equal false, @cell.empty?
  end

end
