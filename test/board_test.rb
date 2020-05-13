require "./lib/board"
require "./lib/cell"
require "./lib/ship"
require "minitest/autorun"
require "minitest/pride"

class BoardTest < MiniTest::Test

  def test_it_exists_with_attributes
    board = Board.new
    assert_instance_of Board, board
    assert_equal ({}), board.cells
  end

end
