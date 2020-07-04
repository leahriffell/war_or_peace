# require all files from the lib directory instead of requiring each individually
Dir[File.join(__dir__, 'lib', '*.rb')].each { |file| require file }


standard_card_deck = CardGenerator.new
standard_card_deck.shuffle_deck
deck1 = standard_card_deck.deal_player1_cards
deck2 = standard_card_deck.deal_player2_cards
player1 = Player.new("Larry David", deck1)
player2 = Player.new("Susie Greene", deck2)


game = Start.new(turn)
game.create_players
turn = Turn.new(game.player1, game.player2)
binding.pry
game.play_the_game(turn)

# loop do


# PLAYERS ARE NIL because Start.new needs  a turn but in order to create a turn I need to initialize the players and decks. Need to generate the cards in a diff. class
# then create players before i can create turn and game
