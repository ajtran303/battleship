require "./lib/board"
require "./lib/cell"
require "./lib/ship"

class Setup

  attr_reader :player_board,
              :player_cruiser,
              :player_submarine

  def initialize
    @player_board = Board.new
    @player_cruiser = Ship.new("Cruiser", 3)
    @player_submarine = Ship.new("Submarine", 2)
  end

  def place_player_ships
    puts "I have laid out my ships on the grid."
    puts "You now need to lay out your two ships."
    puts "The Cruiser is three units long and the Submarine is two units long."
    puts @player_board.render
    puts "Enter the squares for the Cruiser (3 spaces): "
    player_placement_coords = gets.chomp.upcase.split(" ")
    while !@player_board.valid_placement?(@player_cruiser, player_placement_coords)
      puts "Those are invalid coordinates. Please try again:"
      player_placement_coords = gets.chomp.upcase.split(" ")
    end
    @player_board.place(@player_cruiser, player_placement_coords)
    puts @player_board.render(true)
    puts "Enter the squares for the Submarine (2 spaces):"
    player_placement_coords = gets.chomp.upcase.split(" ")
    while !@player_board.valid_placement?(@player_submarine, player_placement_coords)
      puts "Those are invalid coordinates. Please try again:"
      player_placement_coords = gets.chomp.upcase.split(" ")
    end
    @player_board.place(@player_submarine, player_placement_coords)
    puts @player_board.render(true)
  end
end
