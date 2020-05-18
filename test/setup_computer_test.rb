require "minitest/autorun"
require "minitest/pride"
require "./lib/setup_computer"
require "./lib/board"
require "./lib/cell"
require "./lib/ship"

class SetupComputerTest < MiniTest::Test

  def setup
    @cpu_cruiser = Ship.new("Cruiser", 3)
    @cpu_submarine = Ship.new("Submarine", 2)
    @cpu_board = Board.new
    @cpu_setup = SetupComputer.new(@cpu_board, [@cpu_cruiser, @cpu_submarine])
  end

  def test_it_exists_and_has_attributes
    assert_instance_of SetupComputer, @cpu_setup
    assert_equal @cpu_board, @cpu_setup.board
    assert_equal [@cpu_cruiser, @cpu_submarine], @cpu_setup.ships
  end

  def test_it_has_a_cell_coordinate_array_for_rows
    expected =   ["A1", "A2", "A3", "A4",
                  "B1", "B2", "B3", "B4",
                  "C1", "C2", "C3", "C4",
                  "D1", "D2", "D3", "D4"]

    assert_equal expected, @cpu_setup.row_arr
  end

  def test_it_has_a_cell_coordinate_array_for_columns
    expected =   ["A1", "B1", "C1", "D1",
                  "A2", "B2", "C2", "D2",
                  "A3", "B3", "C3", "D3",
                  "A4", "B4", "C4", "D4"]

    assert_equal expected, @cpu_setup.col_arr
  end

  def test_it_knows_how_far_to_look
    assert_equal 2, @cpu_setup.look_ahead(@cpu_cruiser)
    assert_equal 1, @cpu_setup.look_ahead(@cpu_submarine)
  end

  def test_it_can_compute_a_max_index
    assert_equal 15, @cpu_setup.max_index
  end

  def test_it_can_pick_a_random_index_up_to_the_max_index
    n = @cpu_setup.random_index
    range = (0..@cpu_setup.max_index)

    assert_equal true, range.include?(n)
    assert_equal false, !range.include?(n)
  end

  def test_it_can_get_col_or_row_coords_array_for_any_ship_and_index
    assert_equal ["A1", "A2", "A3"], @cpu_setup.slice_row(@cpu_cruiser, 0)
    assert_equal ["D4"], @cpu_setup.slice_row(@cpu_cruiser, @cpu_setup.max_index)

    assert_equal ["A1", "B1"], @cpu_setup.slice_col(@cpu_submarine, 0)
    assert_equal ["D4"], @cpu_setup.slice_col(@cpu_submarine, @cpu_setup.max_index)

    battleship = Ship.new("Battleship", 4)

    assert_equal ["A1", "A2", "A3", "A4"], @cpu_setup.slice_row(battleship, 0)
    assert_equal ["A1", "B1", "C1", "D1"], @cpu_setup.slice_col(battleship, 0)
    assert_equal ["D4"], @cpu_setup.slice_col(battleship, @cpu_setup.max_index)
  end

  def test_it_can_check_its_coords_for_valid_placement
    coords_row = @cpu_setup.slice_row(@cpu_cruiser, 0)
    coords_col = @cpu_setup.slice_col(@cpu_cruiser, 0)

    assert_equal true, @cpu_setup.valid?(@cpu_cruiser, coords_row)
    assert_equal true, @cpu_setup.valid?(@cpu_cruiser, coords_col)

    coords_row = @cpu_setup.slice_row(@cpu_cruiser, @cpu_setup.max_index)
    coords_col = @cpu_setup.slice_col(@cpu_cruiser, @cpu_setup.max_index)

    assert_equal false, @cpu_setup.valid?(@cpu_cruiser, coords_row)
    assert_equal false, @cpu_setup.valid?(@cpu_cruiser, coords_col)
  end

  def test_it_can_place_a_ship_randomly
    assert_equal 0, @cpu_board.cells.count { |_, cell_obj| !cell_obj.empty? }
    @cpu_setup.place_random(@cpu_cruiser)
    assert_equal 3, @cpu_board.cells.count { |_, cell_obj| !cell_obj.empty? }
  end

  def test_it_can_place_another_ship_randomly
    assert_equal 0, @cpu_board.cells.count { |_, cell_obj| !cell_obj.empty? }
    @cpu_setup.place_random(@cpu_submarine)
    assert_equal 2, @cpu_board.cells.count { |_, cell_obj| !cell_obj.empty? }
  end

  def test_it_can_place_all_ships_randomly
    assert_equal 0, @cpu_board.cells.count { |_, cell_obj| !cell_obj.empty? }
    @cpu_setup.place_all_ships
    assert_equal 5, @cpu_board.cells.count { |_, cell_obj| !cell_obj.empty? }
  end

end
