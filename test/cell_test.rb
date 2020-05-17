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
    assert_nil @cell.ship
  end

  def test_empty?
    assert_equal true, @cell.empty?
  end

  def test_place_ship
    @cell.place_ship(@cruiser)
    assert_equal @cruiser, @cell.ship
    assert_equal false, @cell.empty?
  end

  def test_it_knows_if_it_is_fired_upon
    assert_equal false, @cell.fired_upon?
    @cell.fire_upon
    assert_equal true, @cell.fired_upon?
  end

  # render tests
  def test_it_renders_dot_if_not_fired_upon
    cell_1 = Cell.new("B4")
    assert_equal ".", cell_1.render
  end

  def test_it_renders_M_if_the_shot_was_a_miss
    cell_1 = Cell.new("B4")
    cell_1.fire_upon

    assert_equal "M", cell_1.render
  end

  def test_it_renders_a_ship_as_dot_or_S_if_render_true
    cell_2 = Cell.new("C3")
    cruiser = Ship.new("Cruiser", 3)

    cell_2.place_ship(cruiser)

    assert_equal ".", cell_2.render
    assert_equal "S", cell_2.render(true)
  end

  def test_it_renders_H_if_the_shot_hit_or_X_if_ship_sunk
    cell_2 = Cell.new("C3")
    cruiser = Ship.new("Cruiser", 3)

    cell_2.place_ship(cruiser)
    cell_2.fire_upon

    assert_equal "H", cell_2.render
    assert_equal false, cruiser.sunk?

    2.times { cruiser.hit }
    assert_equal true, cruiser.sunk?

    assert_equal "X", cell_2.render
  end

end
