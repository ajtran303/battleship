require "./lib/setup"

class Turn

  def initialize
    @setup = Setup.new
    @player_coord = nil
    @cpu_coord = nil
  end

  def render_cpu
    puts "=============COMPUTER BOARD============="
    puts @setup.cpu_board.render(true)
  end

  def render_player
    puts "==============PLAYER BOARD=============="
    puts @setup.player_board.render(true)
  end

  def player_fire
    puts "Enter the coordinate for your shot:"
      #gets.chomp
      #valid_coordinate?(gets.chomp)
      #if true fire upon coordinate
      #else "Please enter a valid coordinate:"
      #if coord already fired upon inform player
      #reassign @player_coord
  end

  def cpu_fire
    #???
    #fired_upon_array?
    #pick random coord
    #if not fired upon, fire upon
    #reassign @cpu_coord
  end

  def report_player_results
    #Your shot on A4 was a miss.
  end

  def report_cpu_results
    # My shot on C1 was a miss.
  end

end

turn = Turn.new

turn.render_cpu
turn.render_player
turn.player_fire
turn.cpu_fire
turn.report_player_results
turn.report_cpu_results
#check game_over?
# A shot missed
# A shot hit a ship
# A shot sunk a ship
