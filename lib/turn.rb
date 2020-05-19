require "./lib/setup"

class Turn

  attr_reader :setup,
              :cpu_coord

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

  def cpu_fire
    @cpu_coord = setup.player_board.cells.to_a.sample[1]
    until !@cpu_coord.fired_upon?
      @cpu_coord = setup.player_board.cells.to_a.sample[1]
    end
    @cpu_coord.fire_upon
  end

end

# turn = Turn.new
#
# turn.render_cpu
# turn.render_player
# turn.player_fire
# turn.cpu_fire
# turn.report_player_results
# turn.report_cpu_results
#check game_over?
# A shot missed
# A shot hit a ship
# A shot sunk a ship
