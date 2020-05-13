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
    assert_equal ".", cell_1.render

    cell_2 = Cell.new("C3")
    cruiser = Ship.new("Cruiser", 3)

    cell_2.place_ship(cruiser)

    assert_equal ".", cell_2.render

  end

  def test_it_renders_to_M_when_fired_upon_and_is_empty
    cell_1 = Cell.new("B4")

    assert_equal ".", cell_1.render
    assert_equal true, cell_1.empty?

    cell_1.fire_upon

    assert_equal "M", cell_1.render
    assert_equal true, cell_1.fired_upon?
  end

  def test_it_can_change_render_from_dot_to_S_when_it_has_ship
    cell_2 = Cell.new("C3")
    cruiser = Ship.new("Cruiser", 3)

    cell_2.place_ship(cruiser)
    assert_equal false, cell_2.empty?

    assert_equal ".", cell_2.render
    assert_equal "S", cell_2.render(true)
  end

  def test_it_starts_out_not_fired_upon
    cell = Cell.new("B4")
    cruiser = Ship.new("Cruiser", 3)
    cell.place_ship(cruiser)

    assert_equal false, cell.fired_upon?
  end


  def test_it_knows_when_it_becomes_fired_upon
    cell = Cell.new("B4")
    cruiser = Ship.new("Cruiser", 3)
    cell.place_ship(cruiser)

    assert_equal false, cell.fired_upon?

    cell.fire_upon

    assert_equal true, cell.fired_upon?
  end

  def test_it_decreases_ship_health_when_fired_upon
    cell = Cell.new("B4")
    cruiser = Ship.new("Cruiser", 3)
    cell.place_ship(cruiser)

    assert_equal 3, cell.ship.health
    assert_equal false, cell.fired_upon?

    cell.fire_upon

    assert_equal 2, cell.ship.health
    assert_equal true, cell.fired_upon?
  end

  def test_it_does_not_change_M_when_render_true
    cell_1 = Cell.new("B4")
    assert_equal ".", cell_1.render
    assert_equal true, cell_1.empty?

    cell_1.fire_upon
    assert_equal "M", cell_1.render
    assert_equal "M", cell_1.render(true)
    assert_equal "M", cell_1.render

    cell_2 = Cell.new("C3")
    cruiser = Ship.new("Cruiser", 3)

    cell_2.place_ship(cruiser)
    assert_equal false, cell_2.empty?
    assert_equal ".", cell_2.render
    assert_equal "S", cell_2.render(true)
  end

  def test_it_renders_to_H_when_fired_upon_and_has_a_ship
    cell_2 = Cell.new("C3")
    cruiser = Ship.new("Cruiser", 3)

    cell_2.place_ship(cruiser)
    assert_equal "S", cell_2.render(true)
    assert_equal ".", cell_2.render

    cell_2.fire_upon

    assert_equal false, cell_2.empty?
    assert_equal "H", cell_2.render
    assert_equal "H", cell_2.render(true)
  end

end
