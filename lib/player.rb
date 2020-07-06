class Player
  attr_reader :name, :deck

  def initialize(name, deck)
    @name = name
    @deck = deck
  end

  def has_lost?
    @deck.cards.length <= 0 ? true : false
  end

  def card_rank(index)
    deck.cards[index].rank
  end

  def cards_in_hand
    deck.cards.length
  end
end
