require "./lib/board"
require "./lib/cell"
require "./lib/ship"
require "./lib/setup_computer"
require "./lib/setup"
require "./lib/turn"
require "minitest/autorun"
require "minitest/pride"

class TurnTest < MiniTest::Test

  def setup
    @turn = Turn.new
  end

  def test_cpu_fire
    @turn.cpu_fire
    assert_equal true, @turn.cpu_coord.fired_upon?
  end

  def test_get_cpu_shot_result
    @turn.cpu_fire
    assert_equal "M" || "H" || "X", @turn.get_cpu_shot_result
  end

  def test_report_cpu_results
    @turn.cpu_fire
    expected = "My shot on #{@turn.cpu_coord.coordinate} #{@turn.results[@turn.get_cpu_shot_result]}."
    assert_equal expected, @turn.report_cpu_results
  end

end
