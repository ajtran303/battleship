require "minitest/autorun"
require "minitest/pride"
require "./lib/setup"
require "./lib/board"
require "./lib/cell"
require "./lib/ship"

class SetupTest < MiniTest::Test

  def setup
    @cpu_cru = Ship.new("Cruiser", 3)
    @cpu_sub = Ship.new("Submarine", 2)
    @cpu_board = Board.new
    @cpu_setter_upper = Setup.new(@cpu_board, [@cpu_cru, @cpu_sub])
  end

  def test_it_exists_and_has_attributes
    assert_instance_of Setup, @cpu_setter_upper
    assert_equal @cpu_board, @cpu_setter_upper.board
    assert_equal [@cpu_cru, @cpu_sub], @cpu_setter_upper.ships
  end

  def test_it_can_count_how_many_cells_are_on_the_board
    assert_equal 16, @cpu_setter_upper.count_cells
  end

end
