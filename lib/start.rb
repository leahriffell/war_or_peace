require 'pry'

class Start
  attr_reader :turn

  def initialize(turn)
    @turn = turn
    play_the_game
  end

  def game_over?
    @turn.player1.deck.cards.length == 0 || @turn.player2.deck.cards.length == 0
  end


  def play_the_game
    round = 0
    until game_over? || round > 1000000 do
      @turn.pile_cards
      @turn.award_spoils
      @turn.delete_existing_cards_from_players_deck
      p round
      p @turn.player1.deck.cards.length
      p @turn.player2.deck.cards.length
      if @turn.winner == "No Winner"
        p "no winner"
      else
        p "#{@turn.winner.name} #{@turn.type}"
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
