class Setup
  attr_reader :board, :ships

  def initialize(board, ships)
    @board = board
    @ships = ships
  end

  def max_index
    @board.cells.size - 1
  end

  def random_index
    (0..max_index).to_a.sample
  end

  def row_arr
    @board.cells.keys
  end

  def col_arr
    ["A1", "B1", "C1", "D1",
    "A2", "B2", "C2", "D2",
    "A3", "B3", "C3", "D3",
    "A4", "B4", "C4", "D4"]
  end

  def slice_row(ship, index)
    n = look_ahead(ship)
    row_arr[index..(index+n)]
  end

  def slice_col(ship, index)
    n = look_ahead(ship)
    col_arr[index..(index+n)]
  end

  def look_ahead(ship)
    ship.length - 1
  end

  def valid?(ship, coords)
    @board.valid_placement?(ship, coords)
  end

  def place_all_ships
    @ships.each { |ship| place_random(ship) }
  end

  def place_random(ship)
    loop do
      n = random_index
      x = rand(2)
      row = slice_row(ship, n)
      col = slice_col(ship, n)
      if x == 0
        if valid?(ship, row)
          @board.place(ship, row)
          break
        elsif valid?(ship, col)
          @board.place(ship, col)
          break
        end
      else
        if valid?(ship, col)
          @board.place(ship, col)
          break
        elsif valid?(ship, row)
          @board.place(ship, row)
          break
        end
      end
    end
  end

end
