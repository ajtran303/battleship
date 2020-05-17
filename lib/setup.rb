class Setup
  attr_reader :board, :ships

  def initialize(board, ships)
    @board = board
    @ships = ships
  end

  def count_cells
    @board.cells.size
  end

end
