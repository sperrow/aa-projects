# game
#   1 deck
#   n players
#     1 hand
#       5 cards
#
#
#
# game
#   initialize(names)
#     @deck = Deck.new
#     @players = []
#     @pot = 0
#     @current_bet = 0
#     @current_players = []
#     create_players(names)
#     deal
#   end
#
#   create_players(names)
#     names.each |name|
#       @players << Player.new(name)
#     end
#   end
#
#   deal
#     @players.length.times do |player|
#       cards = []
#       5.times { cards << deck.pop }
#       hand = Hand.new(cards)
#       player.deal(hand)
#     end
#
#     @current_players = @players.dup
#   end
#
#   play
#
#
#
#   betting_phase
#     i = first_player
#     until everyone is holding or folding
#       player[i] turn
#         raise
#           @current_bet += raise
#         hold/match
#           # make sure player's bet equals @current
#         fold
#           # @current_players.delete player
#       i += 1
#
#   draw
#     i = first_player
#     players.each
#       player discard n cards
#       player << deck.pop n times
#
#   showdown
#     calculate each player's hand
