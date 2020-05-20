require "./lib/setup"

class Turn

  attr_reader :player_coord, :setup, :cpu_coord

  def initialize
    setup = Setup.new
    @setup = setup
    @player_coord = nil
    @cpu_coord = nil
  end

  def render_cpu
    puts "=============COMPUTER BOARD============="
    puts @setup.cpu_board.render
  end

  def render_player
    puts "==============PLAYER BOARD=============="
    puts @setup.player_board.render(true)
  end

  def update_player_coord(valid_coord)
    @player_coord = valid_coord
  end

  def fire_at_cpu
    if @setup.cpu_board.cells["#{@player_coord}"].fired_upon?
      render_bars
      puts ["Again? Bold strategy!",
            "It was not very effective...",
            "You threw away your shot!!!",
            "You already shot there!!!"].sample
      puts "Hint: don't pick #{@player_coord} again!"
    end
    @setup.cpu_board.cells["#{@player_coord}"].fire_upon
  end

  def get_player_coord
    render_bars
    puts "Enter the coordinate for your shot:"
    loop do
      player_shot_coord = gets.chomp.upcase
      if @setup.player_board.valid_coordinate?(player_shot_coord)
        update_player_coord(player_shot_coord)
        break
      else
        puts "Please enter a valid coordinate:"
      end
    end
  end

  def player_fire
    get_player_coord
    fire_at_cpu
  end

  def render_bars
    s = ""
    40.times { s += "=" }
    puts s
  end

  def report_player_results
    x = get_player_shot_result
    render_bars
    puts "Your shot on #{@player_coord} #{results[x]}."
  end

  def get_player_shot_result
    @setup.cpu_board.cells["#{@player_coord}"].render
  end

  def cpu_fire
    @cpu_coord = setup.player_board.cells.to_a.sample[1]
    until !@cpu_coord.fired_upon?
      @cpu_coord = setup.player_board.cells.to_a.sample[1]
    end
    @cpu_coord.fire_upon
  end

  def get_cpu_shot_result
    @setup.player_board.cells[@cpu_coord.coordinate].render
  end

  def results
    { "M" => "was a miss",
    "H" => "hit a ship",
    "X" => "sunk a ship" }
  end

  def report_cpu_results
    x = get_cpu_shot_result
    puts "My shot on #{@cpu_coord.coordinate} #{results[x]}."
  end

end
