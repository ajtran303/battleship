require "./lib/setup"

class Turn

  attr_reader :player_coord

  def initialize
    setup = Setup.new
    @setup = setup
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

  def update_player_coord(valid_coord)
    @player_coord = valid_coord
  end

  def fire_at_cpu
    if @setup.cpu_board.cells["#{@player_coord}"].fired_upon?
      puts ["Again? Bold strategy!",
            "The ships do not move in this game!",
            "It was not very effective...",
            "You threw away your shot!!!",
            "You already shot there!!!"].sample
      puts "Hint: Next time shoot somewhere else!"
      end
    @setup.cpu_board.cells["#{@player_coord}"].fire_upon
  end

  def player_fire
    loop do
      puts "Enter the coordinate for your shot:"
      player_shot_coord = gets.chomp.upcase
      if @setup.player_board.valid_coordinate?(player_shot_coord)
        update_player_coord(player_shot_coord)
        break
      else
        puts "Those are invalid coordinates. Please try again:"
      end
    end
    fire_at_cpu
  end

  def cpu_fire
  end

  def report_player_results
    x = get_player_shot_result
    results = { "M" => "was a miss",
                "H" => "hit a ship",
                "X" => "sunk a ship" }
    puts "Your shot on #{@player_coord} #{results[x]}."
  end

  def get_player_shot_result
    @setup.cpu_board.cells["#{@player_coord}"].render
  end

  def report_cpu_results
  end

end
