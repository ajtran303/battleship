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

  def test_it_will_not_validate_if_coords_and_ship_lengths_are_not_same
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)

    assert_equal false, board.valid_placement?(cruiser, ["A1", "A2"])
    assert_equal false, board.valid_placement?(submarine, ["A2", "A3", "A4"])
  end

  def test_it_has_a_helper_method_to_check_for_same_length
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    coords_1 = ["A2", "A3", "A4"]
    coords_2 = ["A2", "A3"]

    assert_equal true, board.same_length?(cruiser, coords_1)
    assert_equal false, board.same_length?(cruiser, coords_2)
  end


  def test_it_will_not_validate_if_coords_are_not_consecutive
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)

    assert_equal false, board.valid_placement?(cruiser, ["A1", "A2", "A4"])
    assert_equal false, board.valid_placement?(submarine, ["A1", "C1"])
    assert_equal false, board.valid_placement?(cruiser, ["A3", "A2", "A1"])
    assert_equal false, board.valid_placement?(submarine, ["C1", "B1"])
  end

  def test_it_knows_if_coords_are_consecutive_in_a_row
    board = Board.new
    coords_true = ["A1", "A2", "A3"]
    coords_false = ["A3", "A2", "A1"]

    assert_equal true, board.is_consecutive_row?(coords_true)
    assert_equal false, board.is_consecutive_row?(coords_false)
  end

  def test_it_knows_if_coords_are_consecutive_in_a_column
    board = Board.new
    coords_true = ["A1", "B1", "C1"]
    coords_false = ["C1", "B1", "A1"]

    assert_equal true, board.is_consecutive_col?(coords_true)
    assert_equal false, board.is_consecutive_col?(coords_false)
  end

end
