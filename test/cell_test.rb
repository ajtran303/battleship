require "./lib/cell"
require "./lib/ship"
require "minitest/autorun"
require "minitest/pride"

class CellTest < MiniTest::Test

  def setup
    @cell = Cell.new("B4")
  end

  def test_it_exists
    assert_instance_of Cell, @cell
  end

  def test_it_has_attributes
    assert_equal "B4", @cell.coordinate
    assert_nil @cell.ship
    assert_equal true, @cell.empty?
  end

  def test_it_holds_a_ship
    cruiser = Ship.new("Cruiser", 3)

    @cell.place_ship(cruiser)

    assert_equal cruiser, @cell.ship
    assert_equal false, @cell.empty?
  end

  def test_it_renders_a_cell_with_dot
    cell_1 = Cell.new("B4")
    # cell_2 = Cell.new("C3")
    # cruiser = Ship.new("Cruiser", 3)

    assert_equal ".", cell_1.render
  end

  def test_it_renders_to_m_when_fired_upon_and_has_no_ship
    cell_1 = Cell.new("B4")

    cell_1.render

    cell_1.fire_upon

    assert_equal "M", cell_1.render
  end

end
