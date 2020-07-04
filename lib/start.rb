require 'pry'

class Start
  attr_reader :turn

  def initialize(turn)
    @turn = turn
    play_the_game
  end

  def game_over?
    @turn.player1.deck.cards.length < 0 || @turn.player2.deck.cards.length < 0 || @turn.round > 1000001
  end


  def play_the_game
    until game_over?
      @turn.round += 1
      @turn.pile_cards
      @turn.award_spoils
      p @turn.player1.deck.cards.length
      p @turn.player2.deck.cards.length
        if @turn.type == :basic
          p "Turn #{@turn.round}: #{@turn.winner.name} won #{@turn.spoils_of_war.length} cards"
        elsif @turn.type == :war
          p "Turn #{@turn.round}: WAR - #{@turn.winner.name} won #{@turn.spoils_of_war.length} cards"
        else
          p "Turn #{@turn.round}: *mutually assured destruction* #{@turn.cards_removed_from_game_in_mad} removed from play"
        end
      @turn.delete_existing_cards_from_players_deck
    end
    p "#{@turn.winner.name} won the game!"
  end
end
