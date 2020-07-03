require 'pry'

class Turn
  attr_reader :player1, :player2, :spoils_of_war

  def initialize(player1, player2)
    @player1 = player1
    @player2 = player2
    @spoils_of_war = []
  end

  def type
    if @player1.deck.cards[0].rank == @player2.deck.cards[0].rank && @player1.deck.cards[2].rank == @player2.deck.cards[2].rank
      # what happens when there's no cards left at rank 2?
      :mutually_assured_destruction
    elsif @player1.deck.cards[0].rank == @player2.deck.cards[0].rank
      :war
    else
      :basic
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
    else self.type == :mutually_assured_destruction
      "No Winner"
    end
  end

  # def delete_card
  #   cards.shift
  # end

  def pile_cards
    #spoils of war is the pile in the middle in a turn
    if self.type == :basic
      @spoils_of_war << @player1.deck.cards[0]
      @spoils_of_war << @player2.deck.cards[0]
    elsif self.type == :war
        @spoils_of_war.concat(@player1.deck.cards[0..2])
        @spoils_of_war.concat(@player2.deck.cards[0..2])
    else
      nil
    end
  end

  def award_spoils
    # AND DELETE. this method sends spoils pile to winner then deletes cards placed in spoils pile from both players hands. Doesn't seem like the right spot to delete, but when deleting before this method, it evaluates the winner based on updated arrays with the removal of the spoils pile, thus changing turn type and winner.
    if self.type == :basic
      winner.deck.cards.concat(@spoils_of_war)
      @player1.deck.cards.shift
      @player2.deck.cards.shift
    elsif self.type == :war
      winner.deck.cards.concat(@spoils_of_war)
      3.times do
        @player1.deck.cards.shift
        @player2.deck.cards.shift
      end
    else
      3.times do
        @player1.deck.cards.shift
        @player2.deck.cards.shift
      end
    binding.pry
    end
    # only add cards from the spoils pile if they are not already in the winner's deck of cards

    # spoil_cards_not_in_winner_deck = []
    #
    # if self.type == :basic || self.type == :war
    #   spoil_cards_not_in_winner_deck = @spoils_of_war.select do |card|
    #     !winner.deck.cards.include?(card)
    #   end
    #   winner.deck.cards.concat(spoil_cards_not_in_winner_deck)
    # else self.type == :mutually_assured_destruction
    #   nil
    # end
  end
end
