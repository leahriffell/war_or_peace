# require all files from the lib directory instead of requiring each individually
Dir[File.join(__dir__, 'lib', '*.rb')].each { |file| require file }


# set up the cards and the players
standard_card_deck = CardGenerator.new
standard_card_deck.shuffle_deck
deck1 = Deck.new(standard_card_deck.deal_player1_cards)
deck2 = Deck.new(standard_card_deck.deal_player2_cards)
player1 = Player.new("Larry David", deck1)
player2 = Player.new("Susie Greene", deck2)

p "Welcome to War! (or Peace) This game will be played with 52 cards.
The players today are #{player1.name} and #{player2.name}.
Type 'GO' to start the game!
------------------------------------------------------------------"

turn = Turn.new(player1, player2)

loop do
  start = gets.chomp
  if start == "GO" || "Go"
    Start.new(turn)
  else
    "try typing GO or Go"
  end
end
# loop do
