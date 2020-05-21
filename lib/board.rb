class Board

  attr_reader :cells

  def initialize
    @cells = {
        "A1" => Cell.new("A1"),
        "A2" => Cell.new("A2"),
        "A3" => Cell.new("A3"),
        "A4" => Cell.new("A4"),
        "B1" => Cell.new("B1"),
        "B2" => Cell.new("B2"),
        "B3" => Cell.new("B3"),
        "B4" => Cell.new("B4"),
        "C1" => Cell.new("C1"),
        "C2" => Cell.new("C2"),
        "C3" => Cell.new("C3"),
        "C4" => Cell.new("C4"),
        "D1" => Cell.new("D1"),
        "D2" => Cell.new("D2"),
        "D3" => Cell.new("D3"),
        "D4" => Cell.new("D4")
      }
  end

  def valid_coordinate?(coordinate)
    @cells.include?(coordinate)
  end

  def place(ship, coords)
    coords.each do |coord|
      cells[coord].place_ship(ship)
    end
  end

  def valid_placement?(ship, coords)
    coords.all? { |coord| valid_coordinate?(coord) } &&
    same_length?(ship, coords) &&
    is_consecutive_row_or_col?(coords) &&
    !is_diagonal?(coords) &&
    coords.none? { |coord| is_overlap?(coord) }
  end

  def same_length?(ship, coords)
    ship.length == coords.length
  end

  def is_diagonal?(coords)
    !is_row?(coords) && !is_col?(coords)
  end

  def is_row?(coords)
    coords.all? { |letter| letter[0] == "A"} || coords.all? { |letter| letter[0] == "B"} || coords.all? { |letter| letter[0] == "C"} || coords.all? { |letter| letter[0] == "D"}
  end

  def is_col?(coords)
    coords.all? { |num| num[-1] == "1"} || coords.all? { |num| num[-1] == "2"} || coords.all? { |num| num[-1] == "3"} || coords.all? { |num| num[-1] == "4"}
  end

  def is_consecutive_row_or_col?(coords)
    is_consecutive_row?(coords) || is_consecutive_col?(coords)
  end

  def is_consecutive_row?(coords)
    nums = coords.map { |num| num[-1] }
    range = nums[0]..nums[-1]
    nums == range.to_a
  end

  def is_consecutive_col?(coords)
    letters = coords.map { |let| let[0] }
    range = letters[0]..letters[-1]
    letters == range.to_a
  end

  def is_overlap?(coord)
    !@cells[coord].empty?
  end

  def render(reveal = false)
    rendered_cell = ""
    cells.each do |cell|
       rendered_cell += cell[1].render(reveal) + " "
    end
    "  1 2 3 4 \n" +
    "A #{rendered_cell[0..7]}\n" +
    "B #{rendered_cell[8..15]}\n" +
    "C #{rendered_cell[16..23]}\n" +
    "D #{rendered_cell[24..31]}\n"
  end

end
