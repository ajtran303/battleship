require "./lib/board"
require "./lib/cell"
require "./lib/ship"
require "minitest/autorun"
require "minitest/pride"

class BoardTest < MiniTest::Test

  def test_it_exists_with_attributes
    board = Board.new
    assert_instance_of Board, board
    assert_instance_of Hash, board.cells
    assert_equal 16, board.cells.length
    assert_equal "D3", board.cells["D3"].coordinate
  end

end
