# require all files from the lib directory instead of requiring each individually
Dir[File.join(__dir__, 'lib', '*.rb')].each { |file| require file }

class Game
  attr_reader :standard_card_deck

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
  # print the deck
  # standard_card_deck.each do |card|
  #   p "#{card.suit} #{card.value}"
  # end
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

  def set_up_game
  # Is there a way to automatically run a method whenever you run this file? So that the method doesn't have to explicitly be called?
    shuffle_deck
    deal_player1_cards
    deal_player2_cards
    deck1 = Deck.new(deal_player1_cards)
    deck2 = Deck.new(deal_player2_cards)
    p player1 = Player.new("Larry David", deck1)
    p player2 = Player.new("Susie Greene", deck2)
    p "Welcome to War! (or Peace) This game will be played with 52 cards.
    The players today are #{player1.name} and #{player2.name}.
    Type 'GO' to start the game!
    ------------------------------------------------------------------"
  end

  def play_the_game
    # this should live in a method to get the user input and thennn start game play.
    if gets.chomp == "go" || gets.chomp == "GO"
      "yay let's play!!"
    end
  end
end

# game = Game.new
# game.set_up_game
# game.play_the_game


#
# turn1 = Turn.new(player1, player2)
#
# turn1.pile_cards
# turn1.award_spoils
