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
    player1.deck.cards.length <= 2 || player2.deck.cards.length <= 2
  end

  def type
    if short_deck? == false
      if player1.deck.cards[0].rank == player2.deck.cards[0].rank && player1.deck.cards[2].rank == player2.deck.cards[2].rank
      # what happens when there's no cards left at rank 2?
        :mutually_assured_destruction
      elsif player1.deck.cards[0].rank == player2.deck.cards[0].rank
        :war
      else
        :basic
      end
    else
      :short_deck
    end
  end

  def winner
    # type == without `self` works here because ruby allows for an implicit self. Without it, it wasn't clear to me what object `type` was running on. Adding `self` doesn't change how this is run, but it makes it more explicit.
    if self.type == :basic
      # get rid of these nested ifs by breaking out into diff. methods (ex: winner_basic). This will make it easier to understand what is going on here.
      if @player1.deck.cards[0].rank > @player2.deck.cards[0].rank
        @player1
      else
        @player2
      end
    elsif self.type == :war
      if @player1.deck.cards[2].rank > @player2.deck.cards[2].rank
        @player1
      else
        @player2
      end
    elsif self.type == :mutually_assured_destruction
      "No Winner"
    else self.type == :short_deck
      if @player1.deck.cards.length == 2
        if @player1.deck.cards[0].rank == @player2.deck.cards[0].rank && @player1.deck.cards[1].rank > @player2.deck.cards[1].rank
          @player1
        else @player2.deck.cards[0].rank == @player1.deck.cards[0].rank && @player2.deck.cards[1].rank > @player1.deck.cards[1].rank
          @player2
        end
      elsif @player2.deck.cards.length == 2
        if @player1.deck.cards[0].rank == @player2.deck.cards[0].rank && @player1.deck.cards[1].rank > @player2.deck.cards[1].rank
          @player1
        else @player2.deck.cards[0].rank == @player1.deck.cards[0].rank && @player2.deck.cards[1].rank > @player1.deck.cards[1].rank
          @player2
        end
      elsif @player1.deck.cards.length > 1 && @player1.deck.cards.length > 1
        if @player1.deck.cards[0].rank > @player2.deck.cards[0].rank
          @player1
        elsif @player2.deck.cards[0].rank > @player1.deck.cards[0].rank
          @player2
        elsif @player1.deck.cards[0].rank == @player2.deck.cards[0].rank && @player1.deck.cards.rank[1] == @player2.deck.cards.rank[1]
          "Draw"
        end
      else @player1.deck.cards.length == 0 || @player1.deck.cards.length == 0
        if @player1.deck.cards.length == 0
          @player1
        elsif @player2.deck.cards.length == 0
          @player2
        end
      end
    end
  end

  # def delete_card
  #   cards.shift
  # end

  def pile_cards
    #spoils of war is the pile in the middle in a turn
    if type == :basic
      @spoils_of_war << @player1.deck.cards[0]
      @spoils_of_war << @player2.deck.cards[0]
    elsif type == :war
      @spoils_of_war.concat(@player1.deck.cards[0..2])
      @spoils_of_war.concat(@player2.deck.cards[0..2])
    else
      @cards_removed_from_game_in_mad.concat(@player1.deck.cards[0..2])
      @cards_removed_from_game_in_mad.concat(@player2.deck.cards[0..2])
    end
  end

  def award_spoils
    unless @spoils_of_war.empty?
      winner.deck.cards.concat(@spoils_of_war.shuffle)
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
    else
      3.times do
        @player1.deck.cards.shift
        @player2.deck.cards.shift
      end
    end
    @spoils_of_war = []
  end
end
