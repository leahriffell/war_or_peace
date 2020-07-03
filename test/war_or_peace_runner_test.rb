require 'minitest/autorun'
require 'minitest/pride'
require '../war_or_peace_runner'

class WarOrPeaceRunnerTest < Minitest::Test
  def test_it_exists
    game = Game.new
    assert_instance_of Game, game
  end

  def test_standard_card_deck_is_created
    game = Game.new
    game.create_standard_deck
  end

  def test_cards_are_shuffled
    game = Game.new
    game.shuffle_deck
    #how to test this without writing tons of the combos?
  end

  def test_can_can_start
    #test start method after user types in
  end
end
