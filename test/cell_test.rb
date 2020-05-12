require "./lib/cell"
require "minitest/autorun"
require "minitest/pride"

class CellTest < MiniTest::Test

  def setup
  end

  def test_it_exists
    cell = Cell.new("B4")

    assert_instance_of Cell, cell
  end

end
