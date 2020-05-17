require "./lib/board"
require "./lib/cell"
require "./lib/ship"
require "./lib/setup"
require "minitest/autorun"
require "minitest/pride"

class SetupTest < MiniTest::Test

def test_setup_instance_exists
  setup = Setup.new
  assert_instance_of Setup, setup
end

def test_attribute_access
  setup = Setup.new
  assert_instance_of Board, setup.player_board
  assert_instance_of Ship, setup.cruiser
  assert_instance_of Ship, setup.submarine
end

def test_place_player_ships
  setup = Setup.new
  setup.place_player_ships
  #Test writted using input a1 a2 a3 for cruiser and d1 d2 for sub
  expected = "  1 2 3 4 \nA S S S . \nB . . . . \nC . . . . \nD S S . . \n"
  assert_equal expected, setup.player_board.render(true)
end

end
