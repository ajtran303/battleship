require "./lib/board"
require "./lib/cell"
require "./lib/ship"
require "minitest/autorun"
require "minitest/pride"

class BoardTest < MiniTest::Test

  def setup
    @board = Board.new
    @cruiser = Ship.new("Cruiser", 3)
  end

  def test_it_exists_with_attributes
    assert_instance_of Board, @board
    assert_instance_of Hash, @board.cells
    assert_equal 16, @board.cells.length
    assert_equal "D3", @board.cells["D3"].coordinate
  end

  def test_valid_coordinate?
    assert_equal true, @board.valid_coordinate?("A1")
    assert_equal true, @board.valid_coordinate?("D4")
    assert_equal false, @board.valid_coordinate?("A5")
    assert_equal false, @board.valid_coordinate?("E1")
    assert_equal false, @board.valid_coordinate?("A22")
  end

  def test_place_ship
    @board.place(@cruiser, ["A1", "A2", "A3"])
    cell_1 = @board.cells["A1"]
    cell_2 = @board.cells["A2"]
    cell_3 = @board.cells["A3"]
    assert_equal @cruiser, cell_1.ship
    assert_equal @cruiser, cell_2.ship
    assert_equal @cruiser, cell_3.ship
    assert_equal true, cell_3.ship == cell_2.ship
  end

end
