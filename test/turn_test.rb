require "./lib/board"
require "./lib/cell"
require "./lib/ship"
require "./lib/setup_computer"
require "./lib/setup"
require "./lib/turn"
require "minitest/autorun"
require "minitest/pride"

class TurnTest < MiniTest::Test

  def test_cpu_fire
    turn = Turn.new
    turn.cpu_fire
    assert_equal true, turn.cpu_coord.fired_upon?
  end

end
