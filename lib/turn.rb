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
    @player1.deck.cards.length <= 2 || @player2.deck.cards.length <= 2
  end

  def player1_rank_of_first_card_in_hand
    @player1.deck.cards[0].rank
  end

  def player2_rank_of_first_card_in_hand
    @player2.deck.cards[0].rank
  end

  def player_with_higher_ranking_first_card
    if player1_rank_of_first_card_in_hand > player2_rank_of_first_card_in_hand
      @player1
    else
      @player2
    end
  end

  def player_with_higher_ranking_third_card
    if @player1.deck.cards[2].rank > @player2.deck.cards[2].rank
      @player1
    else
      @player2
    end
  end

  def type
    if short_deck? == false
      if player1_rank_of_first_card_in_hand == player2_rank_of_first_card_in_hand && player1.deck.cards[2].rank == player2.deck.cards[2].rank
        :mutually_assured_destruction
      elsif player1_rank_of_first_card_in_hand == player2_rank_of_first_card_in_hand
        :war
      else
        :basic
      end
    else
      if @player1.deck.cards.length == 2 || @player2.deck.cards.length == 2 && player1_rank_of_first_card_in_hand != player2_rank_of_first_card_in_hand
        :basic
      elsif @player1.deck.cards.length == 2 || @player2.deck.cards.length == 2 && player1_rank_of_first_card_in_hand == player2_rank_of_first_card_in_hand
        :war_with_two_cards
      else @player1.deck.cards.length < 2 || @player2.deck.cards.length < 2
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
      if @player1.deck.cards[1].rank > @player2.deck.cards[1].rank
        @player1
      elsif @player2.deck.cards[1].rank < @player1.deck.cards[1].rank
        @player2
      else @player2.deck.cards[1].rank == @player1.deck.cards[1].rank
        "Draw"
      end
    else self.type == :short_deck
      if @player1.deck.cards.length == 0 || @player2.deck.cards.length == 0
        if @player1.deck.cards.length == 0
          @player1
        elsif @player2.deck.cards.length == 0
          @player2
        end
      elsif @player1.deck.cards.length == 1 || @player2.deck.cards.length == 1
        if player1_rank_of_first_card_in_hand > player2_rank_of_first_card_in_hand
          @player1
        elsif player2_rank_of_first_card_in_hand > player1_rank_of_first_card_in_hand
          @player2
        else player1_rank_of_first_card_in_hand == player2_rank_of_first_card_in_hand
          "Draw"
        end
      end
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
  end

  def award_spoils(turn_winner)
    unless turn_winner == "No Winner" || turn_winner == "Draw"
      turn_winner.deck.cards.concat(@spoils_of_war.shuffle)
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
    @spoils_of_war = []
    @cards_removed_from_game_in_mad = []
  end
end
