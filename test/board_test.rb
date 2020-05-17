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

  def test_it_knows_if_coords_and_ship_are_same_length
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

  def test_it_knows_if_coords_are_in_a_row
    board = Board.new
    coords_true = ["A1", "A2", "A3"]
    coords_false = ["A1", "B1", "C1"]

    assert_equal true, board.is_row?(coords_true)
    assert_equal false, board.is_row?(coords_false)
  end

  def test_it_knows_if_coords_are_in_a_column
    board = Board.new
    coords_true = ["A1", "B1", "C1"]
    coords_false = ["A1", "A2", "A3"]

    assert_equal true, board.is_col?(coords_true)
    assert_equal false, board.is_col?(coords_false)
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

  def test_it_knows_if_coords_are_consecutive_row_or_column
    board = Board.new
    coords_row = ["A1", "A2", "A3"]
    coords_col = ["A1", "B1", "C1"]
    coords_false_1 = ["A3", "A2", "A1"]
    coords_false_2 = ["C1", "B1", "A1"]

    assert_equal true, board.is_consecutive_row_or_col(coords_row)
    assert_equal true, board.is_consecutive_row_or_col(coords_col)
    assert_equal false, board.is_consecutive_row_or_col(coords_false_1)
    assert_equal false, board.is_consecutive_row_or_col(coords_false_2)
  end

  def test_it_knows_if_coords_are_diagonal
    board = Board.new
    coords_row = ["A1", "A2", "A3"]
    coords_col = ["A1", "B1", "C1"]
    coords_diag_1 = ["A1", "B2", "C3"]
    coords_diag_2 = ["C2", "D3"]

    assert_equal false, board.is_diagonal?(coords_row)
    assert_equal false, board.is_diagonal?(coords_col)
    assert_equal true, board.is_diagonal?(coords_diag_1)
    assert_equal true, board.is_diagonal?(coords_diag_2)
  end

  def test_it_will_not_validate_if_coords_are_diagonal
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)

    assert_equal false, board.valid_placement?(cruiser, ["A1", "B2", "C3"])
    assert_equal false, board.valid_placement?(submarine, ["C2", "D3"])
  end

  def test_it_will_validate_if_same_length_AND_consecutive_row_or_column_AND_not_diagonal
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)

    assert_equal true, board.valid_placement?(submarine, ["A1", "A2"])
    assert_equal true, board.valid_placement?(cruiser, ["B1", "C1", "D1"])
  end

  def test_it_will_not_validate_if_ships_overlap
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    board.place(cruiser, ["A1", "A2", "A3"])
    submarine = Ship.new("Submarine", 2)

    assert_equal false, board.valid_placement?(submarine, ["A1", "B1"])
  end

  def test_it_knows_if_coords_is_overlap
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    board.place(cruiser, ["A1", "A2", "A3"])

    assert_equal true, board.is_overlap?("A1")
    assert_equal false, board.is_overlap?("B1")
  end

  def test_it_will_render_if_no_ships_placed
    board = Board.new

    expected =  "  1 2 3 4 \n" +
                "A . . . . \n" +
                "B . . . . \n" +
                "C . . . . \n" +
                "D . . . . \n"

    assert_equal expected, board.render
    assert_equal expected, board.render(true)
  end


  # def test_it_will_render_if_a_ship_is_placed
  #   board = Board.new
  #   cruiser = Ship.new("Cruiser", 3)
  #   board.place(cruiser, ["A1", "A2", "A3"])
  #
  #   expected =  "  1 2 3 4 \n" +
  #               "A S S S . \n" +
  #               "B . . . . \n" +
  #               "C . . . . \n" +
  #               "D . . . . \n"
  #
  #   assert_equal expected, board.render(true)
  #
  #   expected =  "  1 2 3 4 \n" +
  #               "A . . . . \n" +
  #               "B . . . . \n" +
  #               "C . . . . \n" +
  #               "D . . . . \n"
  #
  #   assert_equal expected, board.render
  # end

  # def test_it_will_render_if_a_ship_is_hit
  #   board = Board.new
  #   cruiser = Ship.new("Cruiser", 3)
  #   board.place(cruiser, ["A1", "A2", "A3"])
  #
  #   board.cells["A1"].fire_upon
  #
  #   expected =  "  1 2 3 4 \n" +
  #               "A H . . . \n" +
  #               "B . . . . \n" +
  #               "C . . . . \n" +
  #               "D . . . . \n"
  #
  #   assert_equal expected, board.render
  #
  #   expected =  "  1 2 3 4 \n" +
  #               "A H S S . \n" +
  #               "B . . . . \n" +
  #               "C . . . . \n" +
  #               "D . . . . \n"
  #
  #   assert_equal expected, board.render(true)
  # end
  #
  # def test_it_will_render_if_a_ship_is_sunk
  #   board = Board.new
  #   submarine = Ship.new("Submarine", 2)
  #   board.place(submarine, ["C1", "D1"])
  #
  #   board.cells["C1"].fire_upon
  #
  #   expected =  "  1 2 3 4 \n" +
  #               "A . . . . \n" +
  #               "B . . . . \n" +
  #               "C H . . . \n" +
  #               "D . . . . \n"
  #
  #   assert_equal expected, board.render
  #
  #   board.cells["D1"].fire_upon
  #
  #   expected =  "  1 2 3 4 \n" +
  #               "A . . . . \n" +
  #               "B . . . . \n" +
  #               "C X . . . \n" +
  #               "D X . . . \n"
  #
  #   assert_equal expected, board.render
  # end
  #
  # def test_it_will_render_if_a_shot_missed
  #   board = Board.new
  #   board.cells["B4"].fire_upon
  #
  #   expected =  "  1 2 3 4 \n" +
  #               "A . . . . \n" +
  #               "B . . . M \n" +
  #               "C . . . . \n" +
  #               "D . . . . \n"
  #
  #   assert_equal expected, board.render
  # end
  #
  # def test_it_will_render_everything_that_happens
  #   board = Board.new
  #   cruiser = Ship.new("Cruiser", 3)
  #   submarine = Ship.new("Submarine", 2)
  #   board.place(cruiser, ["A1", "A2", "A3"])
  #   board.place(submarine, ["C1", "D1"])
  #
  #   board.cells["A1"].fire_upon
  #   board.cells["B4"].fire_upon
  #   board.cells["C1"].fire_upon
  #   board.cells["D1"].fire_upon
  #
  #   expected =  "  1 2 3 4 \n" +
  #               "A H . . . \n" +
  #               "B . . . M \n" +
  #               "C X . . . \n" +
  #               "D X . . . \n"
  #
  #   assert_equal expected, board.render
  #
  #   expected =  "  1 2 3 4 \n" +
  #               "A H S S . \n" +
  #               "B . . . M \n" +
  #               "C X . . . \n" +
  #               "D X . . . \n"
  #
  #   assert_equal expected, board.render(true)
  # end

end
