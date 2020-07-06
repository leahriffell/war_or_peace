require 'pry'

class Turn
  attr_reader :player1, :player2, :spoils_of_war, :cards_removed_from_game_in_mad
  attr_accessor :round

  def initialize(player1, player2)
    @player1 = player1
    @player2 = player2
    @spoils_of_war = []
    @cards_removed_from_game_in_mad = []
    @round = 0
  end

  def short_deck?
    @player1.cards_in_hand <= 2 || @player2.cards_in_hand <= 2
  end

  def player_with_higher_ranking_first_card
    if player1.card_rank(0) > player2.card_rank(0)
      @player1
    else
      @player2
    end
  end

  def player_with_higher_ranking_third_card
    if @player1.card_rank(2) > @player2.card_rank(2)
      @player1
    else
      @player2
    end
  end

  def type
    if short_deck? == false
      if player1.card_rank(0) == player2.card_rank(0) && player1.card_rank(2) == player2.card_rank(2)
        :mutually_assured_destruction
      elsif player1.card_rank(0) == player2.card_rank(0)
        :war
      else
        :basic
      end
    else
      if @player1.cards_in_hand == 2 || @player2.cards_in_hand == 2 && player1.card_rank(0) != player2.card_rank(0)
        :basic
      elsif @player1.cards_in_hand == 2 || @player2.cards_in_hand == 2 && player1.card_rank(0) == player2.card_rank(0)
        :war_with_two_cards
      else @player1.cards_in_hand < 2 || @player2.cards_in_hand < 2
        :short_deck
      end
    end
  end

  def winner
    # type == without `self` works here because ruby allows for an implicit self. Without it, it wasn't clear to me what object `type` was running on. Adding `self` doesn't change how this is run, but it makes it more explicit.
    if self.type == :basic
      player_with_higher_ranking_first_card
    elsif self.type == :war
      player_with_higher_ranking_third_card
    elsif self.type == :mutually_assured_destruction
      "No Winner"
    elsif self.type == :war_with_two_cards
      if @player1.card_rank(1) > @player2.card_rank(1)
        @player1
      elsif @player2.card_rank(1) < @player1.card_rank(1)
        @player2
      else @player2.card_rank(1) == @player1.card_rank(1)
        "Draw"
      end
    else self.type == :short_deck
      if @player1.cards_in_hand == 0 || @player2.cards_in_hand == 0
        if @player1.cards_in_hand == 0
          @player1
        elsif @player2.cards_in_hand == 0
          @player2
        end
      elsif @player1.cards_in_hand == 1 || @player2.cards_in_hand == 1
        if player1.card_rank(0) == player2.card_rank(0)
          "Draw"
        elsif player1.card_rank(0) > player2.card_rank(0)
          @player1
        else player2.card_rank(0) > player1.card_rank(0)
          @player2
        end
      end
    end
  end

  def delete_existing_cards_from_players_deck
    if self.type == :basic
      @player1.deck.cards.shift
      @player2.deck.cards.shift
    elsif self.type == :war
      3.times do
        @player1.deck.cards.shift
        @player2.deck.cards.shift
      end
    elsif self.type == :mutually_assured_destruction
      3.times do
        @player1.deck.cards.shift
        @player2.deck.cards.shift
      end
    elsif self.type == :war_with_two_cards || self.type == :short_deck
      2.times do
        @player1.deck.cards.shift
        @player2.deck.cards.clear
      end
    elsif self.type == :short_deck
      @player1.deck.cards.shift
      @player1.deck.cards.shift
    end
  end

  def pile_cards
    #spoils of war is the pile in the middle in a turn
    if type == :basic
      @spoils_of_war << @player1.deck.cards[0]
      @spoils_of_war << @player2.deck.cards[0]
    elsif type == :war
      @spoils_of_war.concat(@player1.deck.cards[0..2])
      @spoils_of_war.concat(@player2.deck.cards[0..2])
    elsif type == :mutually_assured_destruction
      @cards_removed_from_game_in_mad.concat(@player1.deck.cards[0..2])
      @cards_removed_from_game_in_mad.concat(@player2.deck.cards[0..2])
    elsif type == :war_with_two_cards
      @spoils_of_war.concat(@player1.deck.cards[0..1])
      @spoils_of_war.concat(@player2.deck.cards[0..1])
    elsif type == :short_deck
      @spoils_of_war.concat(@player1.deck.cards)
      @spoils_of_war.concat(@player2.deck.cards)
    end
    delete_existing_cards_from_players_deck
  end

  def award_spoils(turn_winner)
    unless turn_winner == "No Winner" || turn_winner == "Draw"
      turn_winner.deck.cards.concat(@spoils_of_war.shuffle)
    end
    @spoils_of_war = []
    @cards_removed_from_game_in_mad = []
  end
end
