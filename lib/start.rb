class Start
  attr_reader :standard_card_deck, :player1, :player2

  def initialize(turn)
    @turn = turn
    play_the_game
  end
  # print the deck
  # standard_card_deck.each do |card|
  #   p "#{card.suit} #{card.value}"
  # end

  def create_players
    shuffle_deck
    deal_player1_cards
    deal_player2_cards
    deck1 = Deck.new(deal_player1_cards)
    deck2 = Deck.new(deal_player2_cards)
    @player1 = Player.new("Larry David", deck1)
    @player2 = Player.new("Susie Greene", deck2)
  end


  # def start_game
  # # Is there a way to automatically run a method whenever you run this file? So that the method doesn't have to explicitly be called?
  #   create_players
  #   # shuffle_deck
  #   # deal_player1_cards
  #   # deal_player2_cards
  #   # deck1 = Deck.new(deal_player1_cards)
  #   # deck2 = Deck.new(deal_player2_cards)
  #   # player1 = Player.new("Larry David", deck1)
  #   # player2 = Player.new("Susie Greene", deck2)
  #   p "Welcome to War! (or Peace) This game will be played with 52 cards.
  #   The players today are #{player1.name} and #{player2.name}.
  #   Type 'GO' to start the game!
  #   ------------------------------------------------------------------"
  # end

  def game_over?
    player1.deck.cards.length == 0 || player2.deck.cards.length == 0
  end


  def play_the_game(turn)
    round = 0
    until turn.game_over? || round > 1000000 do
      turn.pile_cards
      turn.award_spoils
      turn.delete_existing_cards_from_players_deck
      p round
      p player1.deck.cards.length
      p player2.deck.cards.length
      if turn.winner == "No Winner"
        p "no winner :("
      else
        p "#{turn.winner.name} #{turn.type}"
      end
      round += 1
      # turn = Turn.new(turn.player1, turn.player2)
  end
end

  # def play_the_game
  #   # user_response = gets.chomp
  #   # if user_response == "GO" || "go" || "Go" || "gO"
  #   #   # google a method that can allow for any casing combination on go
  #     new_turn
  #   # end
  # end
end
