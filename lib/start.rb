require 'pry'

class Start
  attr_reader :turn

  def initialize(turn)
    @turn = turn
    play_the_game
  end

  def game_over?
    @turn.player1.deck.cards.length == 0 || @turn.player2.deck.cards.length == 0 || @turn.round > 1000001
  end


  def play_the_game
    until game_over?
      @turn.round += 1
      turn_winner = @turn.winner
      @turn.pile_cards
      @turn.award_spoils(turn_winner)
        if @turn.type == "Draw"
          p "---- DRAW ----"
        elsif @turn.type == :basic
          p "Turn #{@turn.round}: #{@turn.winner.name} won #{(@turn.spoils_of_war.length)/2} cards"
        elsif @turn.type == :war
          p "Turn #{@turn.round}: WAR - #{@turn.winner.name} won #{(@turn.spoils_of_war.length)/2} cards"
        elsif @turn.type == :mutually_assured_destruction
          p "Turn #{@turn.round}: *mutually assured destruction* #{@turn.cards_removed_from_game_in_mad.length} removed from play"
        elsif @turn.type == :war_with_two_cards
          p "Turn #{@turn.round}: #{@turn.winner.name} won #{(@turn.spoils_of_war.length)/2} cards"
        else @turn.type == :short_deck
          p "Turn #{@turn.round}: #{@turn.winner.name} won #{(@turn.spoils_of_war.length)/2} cards"
        end
      @turn.delete_existing_cards_from_players_deck
    end
    p "#{@turn.winner.name} won the game!"
  end
end
