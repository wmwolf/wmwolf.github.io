(($) ->

) jQuery

f_dur = 400

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
    $( '.btn-player' ).fadeIn()

  getBid: (bidder) ->
    @bidder = bidder

    $( '.instruct' ).text("Okay, what did #{bidder.name} bid?")
    $( '.instruct' ).fadeIn()
    $( '.btn-bid' ).fadeIn()

  getSuit: (bid) ->
    @bid = bid
    $( '.instruct' ).text("What suit is #{@bidder.name}'s bid in?")
    $( '.instruct' ).fadeIn()
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
      $( '.instruct' ).fadeIn()
      if @bid == 4
        $( '.btn-decision4' ).fadeIn()
      else if @bid == 5
        $( '.btn-decision5' ).fadeIn()
      else
        $( '.btn-decision-other' ).fadeIn()

  getOutcome: () ->
    if @suit == 'clubs'
      $( '.instruct' ).text("Too bad, #{@defendingTeam.name}, you're playing. How many tricks did you get?")
      $( '.instruct' ).fadeIn()
    else
      $( '.instruct' ).text("So #{@defendingTeam.name} is playing! How many " +
        "tricks did they get?")
      $( '.instruct' ).fadeIn()
    $( '.btn-tricks' ).fadeIn()


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

    # Color code sets and weak sets
    if team1Change < 0
      team1ScoreString = "<span style='color:red;'>#{@teams[0].score}</span>"
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
    else
      team1ScoreString = "<span>#{@teams[0].score}</span>"
    if team2Change < 0
      team2ScoreString = "<span style='color:red;'>#{@teams[1].score}</span>"
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
    else
      team2ScoreString = "<span>#{@teams[1].score}</span>"

    # Make moons show up in bid
    if bid == 7
      bid = '&#x1F319;'
    else if bid == 14
      bid = '&#x1F319;&#x1F319;'

    # Make all passes show up right
    if bidder == "Pass"
      bidString = "#{bidder}"
    else
      bidString = "#{bidder}-#{bid}#{suit}"
    $( '#score tr:last' ).after( "<tr><td>#{@i + 1}</td><td>#{dealer.name}</td>" +
      "<td>#{team1ScoreString}</td>" +
      "<td>#{team2ScoreString}</td><td>#{bidString}</td></tr>")
    if wasSet
      $( '#score tr:last' ).addClass('danger')
    if partialSet
      $( '#score tr:last' ).addClass('warning')
    score_1 = "#{@teams[0].score}"
    score_2 = "#{@teams[1].score}"
    $( '#team1-score' ).fadeOut(f_dur/2.0, () ->
      $( '#team2-score' ).fadeOut(f_dur/2.0, () ->     
        $( '#team1-score' ).text score_1
        $( '#team2-score' ).text score_2
        $( '#team1-score' ).fadeIn(f_dur/2.0, () ->
          $( '#team2-score' ).fadeIn(f_dur/2.0)
        )
      )
    )
    if @teams[0].victorious(@teams[1])
      @triggerVictory(@teams[0])
    else if @teams[1].victorious(@teams[0])
      @triggerVictory(@teams[1])
    else
      @i += 1
      @biddingTeam = null
      @defendingTeam = null
      @bidder = null
      @suit = null
      @bid = null
      dealer = @players[@i%4].name 
      if @i < 4
        @setBidder(@players[(@i + 1) % 4])
        @defendingTeam = @teams[@i % 2]
        @biddingTeam = @teams[(@i+1) % 2]
        @bid = 4
        $( '.instruct' ).text("#{dealer} deals and #{@bidder.name} " +
          "automatically bids 4. What suit is it in?")
        $( '.instruct' ).fadeIn()
        $( '.btn-suit' ).fadeIn()
      else
        $( '.instruct' ).text("#{dealer} deals. Who won the bid?")
        $( '.instruct' ).fadeIn()
        $( '.btn-player' ).fadeIn()


  triggerVictory: (team) ->
    $( '.instruct' ).text("#{team.name} has won the game!")
    $( '.instruct' ).fadeIn()    
    $( '#btn-restart' ).fadeIn()

  restart: () ->
    @i = 0
    team.resetScore() for team in @teams
    @bidder = @players[1]
    @bid = 4
    dealer = @players[0]
    $( '#team1-score' ).text "#{@teams[0].score}"
    $( '#team2-score' ).text "#{@teams[1].score}"    
    $( '.instruct' ).text("#{dealer.name} deals and #{@bidder.name} " +
      "automaticlaly bids 4. What suit is it in?")
    $( '.instruct' ).fadeIn()    
    $( '#score' ).html("<tr><th>Hand</th><th>Dealer</th>" +
    "<th>#{@teams[0].name}</th><th>#{@teams[1].name}</th><th>Bid</th></tr>")
    $( '.btn-suit' ).fadeIn()


player1 = new Player 'player1'
player2 = new Player 'player2'
player3 = new Player 'player3'
player4 = new Player 'player4'
team1 = new Team(player1, player3)
team2 = new Team(player2, player4)
game = new PepperGame(team1, team2)
suit_symbols = 
  'clubs':'<span>&#9827;</span>'
  'diamonds':'<span style="color: red;">&#9830</span>;'
  'spades':'<span>&#9824;</span>'
  'hearts':'<span style="color: red;">&#9829</span;'
  'no trump': '<span>&#8709;</span>'


$( document ).ready( ->
  # stuff that happens once the "I like my names" button is pressed
  $( ".names form input" ).keypress( (e) ->
    if ((e.which and e.which == 13) or (e.keyCode and e.keyCode == 13))
      $('#name-submit').click()
      false
    else
      true
  )

  $( '#name-submit' ).click(() ->
    # save player names
    player1.setName $( '#player-1-name' ).val()
    player2.setName $( '#player-2-name' ).val()
    player3.setName $( '#player-3-name' ).val()
    player4.setName $( '#player-4-name' ).val()
    # update prompt for team names
    $( '#team-1-prompt' ).text("#{player1.name} and #{player3.name}'s team")
    $( '#team-2-prompt' ).text("#{player2.name} and #{player4.name}'s team")
    # fill in player names in buttons
    $( '#player-1' ).text(player1.name)
    $( '#player-2' ).text(player2.name)
    $( '#player-3' ).text(player3.name)
    $( '#player-4' ).text(player4.name)
    # fade out name selection screen, then fade in team name selection screen
    # $( '.names' ).fadeOut(f_dur, () -> $( '.teams' ).fadeIn())
    $('.names').fadeOut( () -> 
      # alert($( '.teams' ).html())
      $( '.teams' ).fadeIn()
    )
  )

    
  # stuff that happens once the "I like my team names" button is pressed
  $( ".teams form input" ).keypress( (e) ->
    if ((e.which and e.which == 13) or (e.keyCode and e.keyCode == 13))
      $('#team-submit').click()
      false
    else
      true
  )

  $( '#team-submit' ).click () ->
    # save team names
    team1.setName $( '#team-1-name' ).val()
    team2.setName $( '#team-2-name' ).val()
    # put the appropriate team name in the DOM wherever it should show up
    $( '.team-1' ).text(team1.name)
    $( '.team-2' ).text(team2.name)
    # prep for first pepper hand
    game.setBidder(game.players[(game.i + 1) % 4])
    game.setBid(4)
    $( '.instruct' ).text("#{game.players[game.i % 4].name} deals and " +
      "#{game.bidder.name} automatically bids 4. What suit is it in?")
    # fade out team name selection screen, then bring in everthing in the games
    # setion except the non-suit buttons
    $( '.teams' ).fadeOut(f_dur,  () ->
      $( '.game' ).fadeIn()
      $( '.btn-suit' ).fadeIn()  
    ) 

  # set behavior for every possible button... probably done poorly
  # PepperGame class takes care of showing stuff. Button actions should hide
  # themselves and then call the appropriate method in PepperGame.

  # First do bidder buttons
  $( '#player-1' ).click(() -> 
    $( '.instruct' ).fadeOut(f_dur)
    $( '.btn-player' ).fadeOut(f_dur,  () -> game.getBid(player1))
  )
  $( '#player-2' ).click(() -> 
    $( '.instruct' ).fadeOut(f_dur)
    $( '.btn-player' ).fadeOut(f_dur,  () -> game.getBid(player2))
  )    
  $( '#player-3' ).click(() -> 
    $( '.instruct' ).fadeOut(f_dur)
    $( '.btn-player' ).fadeOut(f_dur,  () -> game.getBid(player3))
  )    
  $( '#player-4' ).click(() -> 
    $( '.instruct' ).fadeOut(f_dur)
    $( '.btn-player' ).fadeOut(f_dur,  () -> game.getBid(player4))
  )    
  $( '#player-no' ).click(() -> 
    $( '.instruct' ).fadeOut(f_dur)
    $( '.btn-player' ).fadeOut(f_dur,  () -> 
      game.updateScores('Pass', '', '', 0, 0)
    )
  )

  # Bid buttons
  $( '#bid-4' ).click(() -> 
    $( '.instruct' ).fadeOut(f_dur)
    $( '.btn-bid' ).fadeOut(f_dur,  () -> game.getSuit(4))
  )    
  $( '#bid-5' ).click(() -> 
    $( '.instruct' ).fadeOut(f_dur)
    $( '.btn-bid' ).fadeOut(f_dur,  () -> game.getSuit(5))
  )    
  $( '#bid-6' ).click(() ->
    $( '.instruct' ).fadeOut(f_dur)
    $( '.btn-bid' ).fadeOut(f_dur,  () -> game.getSuit(6))
  )    
  $( '#bid-7' ).click(() ->
    $( '.instruct' ).fadeOut(f_dur)
    $( '.btn-bid' ).fadeOut(f_dur,  () -> game.getSuit(7))
  )    
  $( '#bid-14' ).click(() ->
    $( '.instruct' ).fadeOut(f_dur)
    $( '.btn-bid' ).fadeOut(f_dur,  () -> game.getSuit(14))
  )    

  # Suit buttons
  $( '#clubs' ).click(() -> 
    $( '.instruct' ).fadeOut(f_dur)
    $( '.btn-suit' ).fadeOut(f_dur,  () -> game.getDecision('clubs'))
  )    
  $( '#diamonds' ).click(() -> 
    $( '.instruct' ).fadeOut(f_dur)
    $( '.btn-suit' ).fadeOut(f_dur,  () -> game.getDecision('diamonds'))
  )
  $( '#spades' ).click(() -> 
    $( '.instruct' ).fadeOut(f_dur)
    $( '.btn-suit' ).fadeOut(f_dur,  () -> game.getDecision('spades'))
  )
  $( '#hearts' ).click(() -> 
    $( '.instruct' ).fadeOut(f_dur)
    $( '.btn-suit' ).fadeOut(f_dur,  () -> game.getDecision('hearts'))
  )
  $( '#no-trump' ).click(() -> 
    $( '.instruct' ).fadeOut(f_dur)
    $( '.btn-suit' ).fadeOut(f_dur,  () -> game.getDecision('no trump'))
  )

  # Decision buttons    
  $( '.pass' ).click(() ->
    if game.teams[0] == game.defendingTeam
      team1Change = game.defChange(0, false)
      team2Change = game.bidChange(0)
    else
      team2Change = game.defChange(0, false)
      team1Change = game.bidChange(0)
    bid = game.bid
    if bid == 4
      cls = '.btn-decision4'
    else if bid == 5   
      cls = '.btn-decision5'
    else
      cls = '.btn-decision-other'
    $( '.instruct' ).fadeOut(f_dur)
    $( cls ).fadeOut(f_dur,  () ->
      game.updateScores(game.bidder.name, game.bid, suit_symbols[game.suit], 
        team1Change, team2Change)
    )
  )
  $( '.pass1' ).click(() ->
    if game.teams[0] == game.defendingTeam
      team1Change = game.defChange(1, false)
      team2Change = game.bidChange(1)
    else
      team2Change = game.defChange(1, false)
      team1Change = game.bidChange(1)
    bid = game.bid
    if bid == 4
      cls = '.btn-decision4'
    else if bid == 5   
      cls = '.btn-decision5'
    else
      cls = '.btn-decision-other'
    $( '.instruct' ).fadeOut(f_dur)
    $( cls ).fadeOut(f_dur,  () ->
      game.updateScores(game.bidder.name, game.bid, suit_symbols[game.suit], 
        team1Change, team2Change)
    )
  )
  $( '.pass2' ).click(() ->
    if game.teams[0] == game.defendingTeam
      team1Change = game.defChange(2, false)
      team2Change = game.bidChange(2)
    else
      team2Change = game.defChange(2, false)
      team1Change = game.bidChange(2)    
    bid = game.bid
    if bid == 4
      cls = '.btn-decision4'
    else if bid == 5   
      cls = '.btn-decision5'
    else
      cls = '.btn-decision-other'
    $( '.instruct' ).fadeOut(f_dur)
    $( cls ).fadeOut(f_dur,  () ->
      game.updateScores(game.bidder.name, game.bid, suit_symbols[game.suit], 
        team1Change, team2Change)
    )
  )
  $( '.play' ).click(() -> 
    bid = game.bid
    if bid == 4
      cls = '.btn-decision4'
    else if bid == 5   
      cls = '.btn-decision5'
    else
      cls = '.btn-decision-other'    
    $( '.instruct' ).fadeOut(f_dur)
    $( cls ).fadeOut(f_dur,  () -> game.getOutcome())
  )

  # Outcome Buttons
  $( '#0-tricks' ).click(() ->
    if game.teams[0] == game.defendingTeam
      team1Change = game.defChange(0, true)
      team2Change = game.bidChange(0)
    else
      team2Change = game.defChange(0, true)
      team1Change = game.bidChange(0)
    $( '.instruct' ).fadeOut(f_dur)
    $( '.btn-tricks' ).fadeOut(f_dur,  () ->
      game.updateScores(game.bidder.name, game.bid, suit_symbols[game.suit],
        team1Change, team2Change)
    )
  )
  $( '#1-tricks' ).click(() ->
    if game.teams[0] == game.defendingTeam
      team1Change = game.defChange(1, true)
      team2Change = game.bidChange(1)
    else
      team2Change = game.defChange(1, true)
      team1Change = game.bidChange(1)
    $( '.instruct' ).fadeOut(f_dur)
    $( '.btn-tricks' ).fadeOut(f_dur,  () ->
      game.updateScores(game.bidder.name, game.bid, suit_symbols[game.suit],
        team1Change, team2Change)
    )
  )
  $( '#2-tricks' ).click(() ->
    if game.teams[0] == game.defendingTeam
      team1Change = game.defChange(2, true)
      team2Change = game.bidChange(2)
    else
      team2Change = game.defChange(2, true)
      team1Change = game.bidChange(2)
    $( '.instruct' ).fadeOut(f_dur)
    $( '.btn-tricks' ).fadeOut(f_dur,  () ->
      game.updateScores(game.bidder.name, game.bid, suit_symbols[game.suit],
        team1Change, team2Change)
    )
  )
  $( '#3-tricks' ).click(() ->
    if game.teams[0] == game.defendingTeam
      team1Change = game.defChange(3, true)
      team2Change = game.bidChange(3)
    else
      team2Change = game.defChange(3, true)
      team1Change = game.bidChange(3)
    $( '.instruct' ).fadeOut(f_dur)
    $( '.btn-tricks' ).fadeOut(f_dur,  () ->
      game.updateScores(game.bidder.name, game.bid, suit_symbols[game.suit],
        team1Change, team2Change)
    )
  )
  $( '#4-tricks' ).click(() ->
    if game.teams[0] == game.defendingTeam
      team1Change = game.defChange(4, true)
      team2Change = game.bidChange(4)
    else
      team2Change = game.defChange(4, true)
      team1Change = game.bidChange(4)
    $( '.instruct' ).fadeOut(f_dur)
    $( '.btn-tricks' ).fadeOut(f_dur,  () ->
      game.updateScores(game.bidder.name, game.bid, suit_symbols[game.suit],
        team1Change, team2Change)
    )
  )
  $( '#5-tricks' ).click(() ->
    if game.teams[0] == game.defendingTeam
      team1Change = game.defChange(5, true)
      team2Change = game.bidChange(5)
    else
      team2Change = game.defChange(5, true)
      team1Change = game.bidChange(5)
    $( '.instruct' ).fadeOut(f_dur)
    $( '.btn-tricks' ).fadeOut(f_dur,  () ->
      game.updateScores(game.bidder.name, game.bid, suit_symbols[game.suit],
        team1Change, team2Change)
    )
  )
  $( '#6-tricks' ).click(() ->
    if game.teams[0] == game.defendingTeam
      team1Change = game.defChange(6, true)
      team2Change = game.bidChange(6)
    else
      team2Change = game.defChange(6, true)
      team1Change = game.bidChange(6)
    $( '.btn-tricks' ).fadeOut(f_dur,  () ->
      game.updateScores(game.bidder.name, game.bid, suit_symbols[game.suit],
        team1Change, team2Change)
    )
  )
  $( '#btn-restart' ).click(() -> $( '#btn-restart' ).fadeOut(f_dur,  () -> game.restart()))
)



