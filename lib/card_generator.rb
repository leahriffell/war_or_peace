class CardGenerator
  def create_standard_deck
    suits = [:club, :diamond, :heart, :spade]
    values = ['2', '3', '4', '5', '6', '7', '8', '9', '10', "Jack", "Queen", "King"]
    ranks = [2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13]
    #should value and rank live in a hash because they are related data points?
    @standard_card_deck = []
    suits.each do |suit|
      # obviously lots of repetition here. Do some nested loops to avoid this and make it more scalable.
      @standard_card_deck << Card.new(suit, '2', 2)
      @standard_card_deck << Card.new(suit, '3', 3)
      @standard_card_deck << Card.new(suit, '4', 4)
      @standard_card_deck << Card.new(suit, '5', 5)
      @standard_card_deck << Card.new(suit, '6', 6)
      @standard_card_deck << Card.new(suit, '7', 7)
      @standard_card_deck << Card.new(suit, '8', 8)
      @standard_card_deck << Card.new(suit, '9', 9)
      @standard_card_deck << Card.new(suit, '10', 10)
      @standard_card_deck << Card.new(suit, 'Jack', 11)
      @standard_card_deck << Card.new(suit, 'Queen', 12)
      @standard_card_deck << Card.new(suit, 'King', 13)
      @standard_card_deck << Card.new(suit, 'Ace', 14)
    end
  end

  def shuffle_deck
    create_standard_deck
    @shuffled_deck = @standard_card_deck.shuffle
  end

  def deal_player1_cards
    @shuffled_deck[0..25]
  end

  def deal_player2_cards
    @shuffled_deck[26..52]
  end
end
