(($) ->

) jQuery

class Team
  constructor: (@player1, @player2) ->
    @name = ''
    @score = 0
    @players = [@player1, @player2]
    for player in @players
      player.setTeam(this)

  updatePoints: (newPoints) ->
    @score += newPoints
    newPoints

  setName: (newName) ->
    @name = newName

  victorious: (otherTeam) ->
    (@score > otherTeam.score) and (@score >= 42)

  resetScore: () ->
    @score = 0

class Player
  constructor: (@name) ->
    @teamAffil = null

  setTeam: (newTeam) ->
    @teamAffil = newTeam

  setName: (newName) ->
    @name = newName

class PepperGame
  constructor: (@team1, @team2) ->
    @i = 0
    @teams = [@team1, @team2]
    @players = [@team1.players[0], @team2.players[0], @team1.players[1],
    @team2.players[1]]
    @biddingTeam = null
    @defendingTeam = null
    @bidder = null
    @suit = null
    @bid = null

  setBidder: (newBidder) ->
    @bidder = newBidder

  setBid: (newBid) ->
    @bid = newBid

  getBidder: () ->
    dealer = @players[@i % 4]
    $( '.instruct' ).text("#{dealer.name} deals. Who won the bid?")
    $( 'btn').hide()
    $( '.btn-player' ).show()

  getBid: (bidder) ->
    @bidder = bidder

    $( '.instruct' ).text("Okay, what did #{bidder.name} bid?")
    $( '.btn').hide()
    $( '.btn-bid' ).show()

  getSuit: (bid) ->
    @bid = bid
    $( '.instruct' ).text("What suit is #{@bidder.name}'s bid in?")
    $( '.btn').hide()
    $( '.btn-suit' ).show()

  getDecision: (suit) ->
    @suit = suit
    @biddingTeam = @bidder.teamAffil
    for team in @teams
      if @bidder not in team.players
        @defendingTeam = team

    if @suit == 'clubs'
      this.getOutcome()
    else
      $( '.instruct' ).text("What will #{@defendingTeam.name} do?")
      $( '.btn').hide()
      $( '#pass' ).show()
      $( '#play' ).show()
      if @bid < 6
        $( '#pass1' ).show() 
      if @bid < 5
        $( '#pass2' ).show()

  getOutcome: () ->
    if @suit == 'clubs'
      $( '.instruct' ).text("Too bad, #{@defendingTeam.name}, you're playing. How many tricks did you get?")
    else
      $( '.instruct' ).text("So #{@defendingTeam.name} is playing! How many " +
        "tricks did they get?")
    $( '.btn' ).hide()
    $( '.btn-tricks' ).show()


  defChange: (defenseTricks, theyStayed) ->
    if defenseTricks > 0
      if @bid > 6
        @bid
      else
        defenseTricks
    else
      if theyStayed then -@bid  else 0

  bidChange: (defenseTricks) ->
    if @bid < 7
      tricksAvailable = 6 - @bid
    else
      tricksAvailable = 0
    if defenseTricks <= tricksAvailable
      @bid
    else
      -@bid

  updateScores: (bidder, bid, suit, team1Change, team2Change) ->
    @teams[0].updatePoints(team1Change)
    @teams[1].updatePoints(team2Change)
    dealer = @players[@i % 4]
    pepper = false
    if @i < 4
      pepper = true

    partialSet = false
    wasSet = false
    if team1Change < 0
      if @teams[0] == @defendingTeam
        if @suit == 'clubs'
          partialSet = true
        else
          wasSet = true
      else
        if pepper
          partialSet = true
        else
          wasSet = true
    if team2Change < 0
      if @teams[1] == @defendingTeam
        if @suit == 'clubs'
          partialSet = true
        else
          wasSet = true
      else
        if pepper
          partialSet = true
        else
          wasSet = true
          
    $( '#score tr:last' ).after( "<tr><td>#{@i + 1}</td><td>#{dealer.name}</td>" +
      "<td>#{bidder}-#{bid}#{suit}</td><td>#{@teams[0].score}</td>" +
      "<td>#{@teams[1].score}</td></tr>")
    if wasSet
      $( '#score tr:last' ).addClass('danger')
    if partialSet
      $( '#score tr:last' ).addClass('warning')
    if @teams[0].victorious(@teams[1])
      @triggerVictory(@teams[0])
    if @teams[1].victorious(@teams[0])
      @triggerVictory(@teams[1])
    else
      @i += 1
      $( '.btn').hide()
      @biddingTeam = null
      @defendingTeam = null
      @bidder = null
      @suit = null
      @bid = null      
      if @i < 4
        @bidder = @players[(@i + 1) % 4]
        @bid = 4
        $( '.instruct' ).text("#{@players[i%4]} deals and #{@bidder.name} " +
          "automaticlaly bids 4. What suit is it in?")
        $( '.btn-suit' ).show()
      else
        $( '.instruct' ).text("#{@players[@i%4].name} deals. Who won the bid?")
        $( '.btn-player' ).show()

  triggerVictory: (team) ->
    $( '.instruct' ).text("#{team.name} has won the game!")
    $( '.btn' ).hide()
    $( '#btn-restart' ).show()

  restart: () ->
    @i = 0
    team.resetScore() for team in @teams
    @bidder = @players[1]
    @bid = 4
    dealer = @players[0]
    $( '.instruct' ).text("#{dealer.name} deals and #{@bidder.name} " +
      "automaticlaly bids 4. What suit is it in?")
    $( '.btn' ).hide()
    $( '.btn-suit' ).show()

player1 = new Player 'player1'
player2 = new Player 'player2'
player3 = new Player 'player3'
player4 = new Player 'player4'
team1 = new Team(player1, player3)
team2 = new Team(player2, player4)
game = new PepperGame(team1, team2)
suit_symbols = 
  'clubs':'&#9827;'
  'diamonds':'&#9830;'
  'spades':'&#9824;'
  'hearts':'&#9829;'
  'no trump': '&#8709;'


$( document ).ready( ->
  $( '#name-submit' ).click () ->
    player1.setName $( '#player-1-name' ).val()
    player2.setName $( '#player-2-name' ).val()
    player3.setName $( '#player-3-name' ).val()
    player4.setName $( '#player-4-name' ).val()
    $( '#team-1-prompt' ).text("#{player1.name} and #{player3.name}'s team")
    $( '#team-2-prompt' ).text("#{player2.name} and #{player4.name}'s team")
    $( '#player-1' ).text(player1.name)
    $( '#player-2' ).text(player2.name)
    $( '#player-3' ).text(player3.name)
    $( '#player-4' ).text(player4.name)
    $( '.names' ).toggleClass 'hidden'
    $( '.teams' ).toggleClass 'hidden'

  $( '#team-submit' ).click () ->
    team1.setName $( '#team-1-name' ).val()
    team2.setName $( '#team-2-name' ).val()
    $( '.team-1' ).text(team1.name)
    $( '.team-2' ).text(team2.name)
    $( '.teams' ).toggleClass 'hidden'
    $( '.game' ).toggleClass 'hidden'
    game.setBidder(game.players[(game.i + 1) % 4])
    game.setBid(4)
    $( '.instruct' ).text("#{game.bidder.name} " +
      "automaticlaly bids 4. What suit is it in?")
    $( '.btn' ).hide()
    $( '.btn-suit' ).show()

  # set behavior for every possible button... probably done poorly
  # PepperGame class takes care of hiding and showing stuff

  # First do bidder buttons
  $(' #player-1' ).click () ->
    game.getBid(player1)
  $(' #player-2' ).click () ->
    game.getBid(player2)
  $(' #player-3' ).click () ->
    game.getBid(player3)
  $(' #player-4' ).click () ->
    game.getBid(player4)
  $(' #player-no' ).click () ->
    game.updateScores('Pass', '', '', 0, 0)

  # Bid buttons
  $( '#bid-4' ).click () ->
    game.getSuit(4)
  $( '#bid-5' ).click () ->
    game.getSuit(5)
  $( '#bid-6' ).click () ->
    game.getSuit(6)
  $( '#bid-7' ).click () ->
    game.getSuit(7)
  $( '#bid-14' ).click () ->
    game.getSuit(14)

  # Suit buttons
  $( '#clubs' ).click () ->
    game.getDecision('clubs')
  $( '#diamonds' ).click () ->
    game.getDecision('diamonds')
  $( '#spades' ).click () ->
    game.getDecision('spades')
  $( '#hearts' ).click () ->
    game.getDecision('hearts')
  $( '#no-trump' ).click () ->
    game.getDecision('no trump')

  # Decision buttons    
  $( '#pass' ).click () ->
    if game.teams[0] == game.defendingTeam
      team1Change = game.defChange(0, false)
      team2Change = game.bidChange(0)
    else
      team2Change = game.defChange(0, false)
      team1Change = game.bidChange(0)
    game.updateScores(game.bidder.name, game.bid, suit_symbols[game.suit], 
      team1Change, team2Change)
  $( '#pass1' ).click () ->
    if game.teams[0] == game.defendingTeam
      team1Change = game.defChange(1, false)
      team2Change = game.bidChange(1)
    else
      team2Change = game.defChange(1, false)
      team1Change = game.bidChange(1)    
    game.updateScores(game.bidder.name, game.bid, suit_symbols[game.suit],
      team1Change, team2Change)
  $( '#pass2' ).click () ->
    if game.teams[0] == game.defendingTeam
      team1Change = game.defChange(2, false)
      team2Change = game.bidChange(2)
    else
      team2Change = game.defChange(2, false)
      team1Change = game.bidChange(2)    
    game.updateScores(game.bidder.name, game.bid, suit_symbols[game.suit],
      team1Change, team2Change)
  $( '#play' ).click () ->
    game.getOutcome()

  # Outcome Buttons
  $( '#0-tricks' ).click () ->
    if game.teams[0] == game.defendingTeam
      team1Change = game.defChange(0, true)
      team2Change = game.bidChange(0)
    else
      team2Change = game.defChange(0, true)
      team1Change = game.bidChange(0)
    game.updateScores(game.bidder.name, game.bid, suit_symbols[game.suit],
      team1Change, team2Change)
  $( '#1-tricks' ).click () ->
    if game.teams[0] == game.defendingTeam
      team1Change = game.defChange(1, true)
      team2Change = game.bidChange(1)
    else
      team2Change = game.defChange(1, true)
      team1Change = game.bidChange(1)
    game.updateScores(game.bidder.name, game.bid, suit_symbols[game.suit],
      team1Change, team2Change)
  $( '#2-tricks' ).click () ->
    if game.teams[0] == game.defendingTeam
      team1Change = game.defChange(2, true)
      team2Change = game.bidChange(2)
    else
      team2Change = game.defChange(2, true)
      team1Change = game.bidChange(2)
    game.updateScores(game.bidder.name, game.bid, suit_symbols[game.suit],
      team1Change, team2Change)
  $( '#3-tricks' ).click () ->
    if game.teams[0] == game.defendingTeam
      team1Change = game.defChange(3, true)
      team2Change = game.bidChange(3)
    else
      team2Change = game.defChange(3, true)
      team1Change = game.bidChange(3)
    game.updateScores(game.bidder.name, game.bid, suit_symbols[game.suit],
      team1Change, team2Change)
  $( '#4-tricks' ).click () ->
    if game.teams[0] == game.defendingTeam
      team1Change = game.defChange(4, true)
      team2Change = game.bidChange(4)
    else
      team2Change = game.defChange(4, true)
      team1Change = game.bidChange(4)
    game.updateScores(game.bidder.name, game.bid, suit_symbols[game.suit],
      team1Change, team2Change)
  $( '#5-tricks' ).click () ->
    if game.teams[0] == game.defendingTeam
      team1Change = game.defChange(5, true)
      team2Change = game.bidChange(5)
    else
      team2Change = game.defChange(5, true)
      team1Change = game.bidChange(5)
    game.updateScores(game.bidder.name, game.bid, suit_symbols[game.suit],
      team1Change, team2Change)
  $( '#6-tricks' ).click () ->
    if game.teams[0] == game.defendingTeam
      team1Change = game.defChange(6, true)
      team2Change = game.bidChange(6)
    else
      team2Change = game.defChange(6, true)
      team1Change = game.bidChange(6)
    game.updateScores(game.bidder.name, game.bid, suit_symbols[game.suit],
      team1Change, team2Change)

  $( '#btn-restart' ).click () ->
    $( '#score tr' ).hide()
    game.restart()
)



