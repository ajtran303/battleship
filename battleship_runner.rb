require "./lib/board"
require "./lib/cell"
require "./lib/ship"
require "./lib/setup_computer"
require "./lib/setup"

setup = Setup.new

setup.place_cpu_ships
setup.place_player_ships
