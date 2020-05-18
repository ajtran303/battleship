require "./lib/turn"

class Starter

  def initialize
    @turn = nil
    render_bars
    main_menu
    start_game
    end_game
  end

  def main_menu
    greet
    p_or_q_loop
  end

  def greet
    puts "Welcome to BATTLESHIP"
    prompt
  end

  def prompt
    puts "Enter p to play. Enter q to quit."
  end

  def render_bars
    s = ""
    40.times { s += "=" }
    puts s
  end

  def p_or_q_loop
    invalid_counter = 4
    loop do
      x = gets.chomp.downcase
      if x == "p"
        start_new_turn
        break
      elsif x == "q"
        exit
      else
        invalid_counter -= 1
        puts "Invalid input! #{invalid_counter} attempts remaining." unless invalid_counter.zero?
        puts "Goodbye!" if invalid_counter.zero?
        exit if invalid_counter.zero?
        prompt
      end
    end
  end

  def start_new_turn
    @turn = Turn.new
  end

  def start_game
    loop do
      @turn.render_cpu
      @turn.render_player
      break if game_over?
      @turn.player_fire
      @turn.cpu_fire
      @turn.report_player_results
      @turn.report_cpu_results
    end
  end

  def end_game
    2.times { render_bars }
    puts "You won!" if cpu_lost?
    puts "I won!" if player_lost?
    2.times { render_bars }
    main_menu
  end

  def game_over?
    player_lost? || cpu_lost?
  end

  def player_ship_arr
    [ @turn.setup.player_cruiser, @turn.setup.player_submarine ]
  end

  def cpu_ship_arr
    [ @turn.setup.cpu_cruiser, @turn.setup.cpu_submarine ]
  end

  def player_lost?
    player_ship_arr.all? { |ship| ship.sunk? }
  end

  def cpu_lost?
    cpu_ship_arr.all? { |ship| ship.sunk? }
  end

end
