require "./lib/turn"
require "./lib/setup"
require "./lib/setup_computer"
require "./lib/board"
require "./lib/cell"
require "./lib/ship"
require "minitest/autorun"
require "minitest/pride"

class TurnTest < MiniTest::Test

  def test_it_exists
    turn = Turn.new
    assert_instance_of Turn, turn
  end

  def test_it_has_a_readable_player_coord
    turn = Turn.new
    assert_nil turn.player_coord
  end

  def test_it_can_update_the_player_coord_after_valid_inputs
    turn = Turn.new
    turn.update_player_coord("A1")
    assert_equal "A1", turn.player_coord
  end

  def test_it_has_a_hash_of_results_messages
    turn = Turn.new

    expected = {"M" => "was a miss",
                "H" => "hit a ship",
                "X" => "sunk a ship"}

    assert_equal expected, turn.results
    assert_equal "was a miss", turn.results["M"]
    assert_equal "hit a ship", turn.results["H"]
    assert_equal "sunk a ship", turn.results["X"]
  end

end
