# (($) ->
  
# ) jQuery

class Player

  constructor: (@name) ->
    @scores = []
    @bids = []
    @tricks = []

  set_tricks: (hand, new_tricks) ->
    if @tricks.length == hand - 1
      # haven't recorded these tricks yet, add it to the end
      @tricks.push new_tricks
    else if @bids.length >= hand
      # tricks already recorded, edit it
      @tricks[hand - 1] = new_tricks

  get_tricks: (hand) ->
    if @tricks.length == 0
      0
    else
      @tricks[hand - 1]

  remove_tricks: (hand) ->
    if @tricks.length >= hand
      # throw out that one element
      destroyed = @tricks.splice(hand - 1, 1)
      

  set_bid: (hand, new_bid) ->
    if @bids.length == hand - 1
      # haven't placed a bid yet, add it to the end
      @bids.push new_bid
    else if @bids.length == hand
      # bid has already been placed; edit it
      @bids[hand - 1] = new_bid
      
  get_bid: (hand) ->
    if @bids.length < hand
      0
    else
      @bids[hand - 1]

  remove_bid: (hand) ->
    if @bids.length >= hand
      # throw out that one element
      @bids.splice(hand - 1, 1)

  get_score: (hand) ->
    if @scores.length < hand
      0
    else
      @scores[hand - 1]

  remove_score: (hand) ->
    if @scores.length >= hand
      # throw out that one element
      @scores.splice(hand - 1, 1)


  update_score: (hand) ->
    bid = @get_bid(hand)
    tricks = @get_tricks(hand)
    score = 0
    to_add = 0
    if hand > 1
      score = @get_score(hand - 1)
    if bid == tricks
      if bid == 0
        to_add = 5
      else
       to_add = 10 + bid
    if @scores.length == 0
      # there are no scores, so just tack on this hand's score
      @scores.push to_add
    else if @scores.length == hand - 1
      # We only have last hand's score, so we need to add a new score to the 
      # array
      @scores.push(@get_score(hand - 1) + to_add)
    else if @scores.length == hand
      # updating most recent score
      @scores[hand - 1] = @get_score(hand - 1) + to_add
    else
      alert('Error updating score. Your game is probably borked. Sorry.')
      console.log("Error updating scores. Info:")
      console.log("  player: #{@name}")
      console.log("  scores length: #{@scores.length}")
      console.log("  bids length: #{@bids.length}")
      console.log("  tricks length: #{@tricks.length}")
      console.log("  last bid: #{@bids[@tricks.length - 1]}")
      console.log("  last tricks: #{@tricks[@tricks.length - 1]}")
      console.log("  last score: #{@scores[@scores - 1]}")
      
    
class Game

  constructor: (@players, @half_game, @max_cards) ->
    @num_players = @players.length
    @phase = 0

  zero_hand: () ->
    @phase // 2

  hand: () ->
    @phase // 2 + 1

  dealer: () ->
    @players[@zero_hand() % @num_players]

  num_hands: () ->
    if @half_game
      @max_cards
    else
      2 * @max_cards

  hand_size: () ->
    if @half_game
      @hand
    else
      Math.min(@hand(), @num_hands() - @hand() + 1)

  over: () ->
    @hand() > @num_hands()

  winners: () ->
    high_score = -1
    winners = []
    for player in @players
      do (player) ->
        score = player.scores[player.scores.length - 1]
        if score > high_score
          winners = [player]
          high_score = score
        else if score == high_score
          winners.push player
    winners          

f_dur = 400

Main =
  max_players: 26
  max_cards: 7
  num_hands: 14
  half_game: false
  setup_valid: false
  setup: ->
    $('#setup').fadeIn(f_dur)

    Main.num_players = parseInt($('#num_players').val(), 10)
    $("div\#player-#{i}").hide() for i in [(Main.num_players + 1)..Main.max_players]

    $('#num_players').off('change')
    $('#num_players').change ->
      Main.num_players = parseInt($('#num_players').val(), 10)
      Main.update_players()

    $('input.player-name').off('change')
    $('input.player-name').change ->
      if $(this).val().length > 0
        $(this).removeClass('is-invalid')
      else
        $(this).addClass('is-invalid')
      Main.check_setup()

    $('#max_cards_slider').off('change')
    $('#max_cards_slider').change ->
      Main.max_cards = parseInt($('#max_cards_slider').val(), 10)
      $('h1#max_cards').text(Main.max_cards)
      $('.summary-max-cards').text(Main.max_cards)
      if Main.half_game
        Main.num_hands = Main.max_cards
      else
        Main.num_hands = 2 * Main.max_cards

    $('#half_game').off('change')
    $('#half_game').change ->
      Main.half_game = $('#half_game').is(':checked')
      if Main.half_game
        Main.num_hands = Main.max_cards
        $('#summary-full-game').fadeOut(f_dur/2)
      else
        Main.num_hands = 2 * Main.max_cards
        $('#summary-full-game').fadeIn(f_dur/2)

    Main.update_players
    Main.update_max_cards

    # clicking the "get going" button, but destroy any existing ones
    $('button#setup-submit').off('click')
    $('button#setup-submit').click ->
      Main.check_setup()
      if Main.setup_valid
        # everything looks good. Set up game with data from form and start
        # first bidding hand
        $('div#setup').fadeOut(f_dur / 2 , ->
          players = []
          players.push new Player($("\#player-#{i}-name").val()) for i in [1..Main.num_players]
          Main.game = new Game(players, Main.half_game, Main.max_cards)
          ScoreSheet.setup()
          Bid.setup())
        
      else
        Main.mark_invalid()

  update_players: ->
    num = Main.num_players
    $("div\#player-#{i}").slideUp(f_dur/2) for i in [(num + 1)..Main.max_players]
    $("div\#player-#{i}").slideDown(f_dur/2) for i in [2..num]
        
    $('#summary-players').text(num)
    Main.update_max_cards()
    Main.check_setup()


  update_max_cards: ->
    max_num = 51 // Main.num_players
    min_num = 2
    $('#max_cards_slider').attr('min', min_num)
    $('#max_cards_slider').attr('max', max_num)
    if Main.max_cards > max_num
      Main.max_cards = max_num
      $('h1#max_cards').text(Main.max_cards)
      $('.summary-max-cards').text(Main.max_cards)

  check_setup: ->
    res = true
    i = 1
    for i in [1..Main.num_players]
      do (i) ->
        res = (res and ($("\#player-#{i}-name").val().length > 0))
    res = res and Main.max_cards <= 51 // Main.num_players
    Main.setup_valid = res
    if Main.setup_valid
      $('#setup-submit').removeClass('disabled')
    else
      $('#setup-submit').addClass('disabled')

  mark_invalid: ->
    for i in [1..Main.num_players]
      do (i) ->
        if $("\#player-#{i}-name").val().length == 0
          $("\#player-#{i}-name").addClass('is-invalid')
        else
          $("\#player-#{i}-name").removeClass('is-invalid')


Bid = 
  bid_sum: 0
  non_dealer_bid_sum: 0
  bids_valid: false
  setup: ->
    # set up basic info
    hand = Main.game.hand()
    Bid.bids_valid = false
    Bid.bid_sum = 0
    Bid.non_dealer_bid_sum = 0

    # ensure confirm button appears disabled
    $('button#bids-submit').addClass('disabled')

    # update dealer name
    $('b#dealer').text(Main.game.dealer().name)
    hand_size = Main.game.hand_size()

    # update number of cards
    if Main.game.hand_size() == 1
      $('span#num-cards').text("#{hand_size} card")
    else
      $('span#num-cards').text("#{hand_size} cards")

    # possibly hide text about revealing trump card
    console.log("is half game? #{Main.game.half_game}")
    console.log("in first half? #{(2 * hand) <= Main.game.num_hands()}")
    unless (Main.game.half_game) or ((2 * hand) <= Main.game.num_hands())
      $('span#reveal-trump').hide()

    # nuke bid buttons from previous bidding round
    $('#bid-players').html('')

    # create buttons for each players bids
    # start with player just after dealer, which is coincidentally found at
    # index hand % number_of_players
    for i in [hand..(hand + Main.game.num_players - 1)]
      do (i) ->
        j = i % Main.game.num_players
        player = Main.game.players[j]
        to_insert = "<h4>#{player.name}'s bid</h4>"
        to_insert = to_insert + "<div class='btn-group mb-2' role='group' aria-label='#{player.name} bid'>"
        for k in [0..hand_size]
          do (k) ->
            to_insert = to_insert + "<button type=button data-player-i=#{j} data-bid=#{k} class='btn btn-outline-primary bid-button'>#{k}</button>"
        to_insert = to_insert + "</div>"

        # add the button group and label to the DOM
        $(to_insert).appendTo('#bid-players')

    # set up listener to make sure bids are recorded, but destroy any
    # previous ones
    $('button.bid-button').off('click')
    $('button.bid-button').click ->
      self = this
      i = parseInt($(this).data('player-i'))
      player = Main.game.players[i]
      hand = Main.game.hand()
      # hand_size = Main.game.hand_size()
      perfect_bid = hand_size - Bid.non_dealer_bid_sum

      bid = parseInt($(this).data('bid'))
      # screw the dealer. They can't make a bid that causes the total bid to
      # be equal to the total number of cards
      if (player == Main.game.dealer()) and (bid == perfect_bid)
        alert('nice try!')
        return

      # mark button as active and actually set bid in player object
      $("[data-player-i=#{i}]").removeClass('active')
      $(self).addClass('active')
      player.set_bid(hand, bid)

      # update sum of the current bids, and disable the "perfect fit" button
      # for dealer, if necessary
      Bid.bid_sum = 0
      Bid.non_dealer_bid_sum = 0
      for player in Main.game.players
        do (player) ->
          Bid.bid_sum += player.get_bid(hand)
          if player != Main.game.dealer()
            Bid.non_dealer_bid_sum += player.get_bid(hand)
      perfect_bid = hand_size - Bid.non_dealer_bid_sum

      Bid.update_dealer_buttons(perfect_bid)

      # Check to see if bids are good to go
      valid = true
      # has each player made a bid?
      for player in Main.game.players
        do (player) ->
          valid = valid and player.bids.length == hand
          valid = valid and player.get_bid(hand) >= 0
          valid = valid and player.get_bid(hand) <= hand_size
      valid = valid and Bid.bid_sum != hand_size
      Bid.bids_valid = valid

      if valid
        $('button#bids-submit').removeClass('disabled')
      else
        $('button#bids-submit').addClass('disabled')

    # set up listener for back button, but destroy any existing handlers
    $('button#bids-back').off('click')
    $('button#bids-back').click ->
      Bid.go_back Main.game.hand()

    # set up listener for submit button, but destroy any existing handlers
    $('button#bids-submit').off('click')
    $('button#bids-submit').click (evt) ->
      evt.stopPropagation()
      evt.preventDefault()
      if Bid.bids_valid
        ScoreSheet.add_bids(hand)
        Main.game.phase += 1
        $('div#bid').fadeOut(f_dur / 2, Tricks.setup)
      else
        alert("Make sure all players have recorded bids and that the total "+
              "sum of the bids does not equal #{hand_size}.")

    $('div#play-area').fadeIn()
    $('div#bid').fadeIn()

  update_dealer_buttons: (perfect_bid) ->
    dealer_i = Main.game.players.indexOf(Main.game.dealer())

    # make all buttons have normal primary color outlines
    $("button[data-player-i=#{dealer_i}]").addClass('btn-outline-primary')
    $("button[data-player-i=#{dealer_i}]").removeClass('btn-outline-danger')

    # make the perfect bid button, if it exists, be inactive and red
    $("button[data-player-i=#{dealer_i}][data-bid=#{perfect_bid}]").removeClass('btn-outline-primary')
    $("button[data-player-i=#{dealer_i}][data-bid=#{perfect_bid}]").removeClass('active')
    $("button[data-player-i=#{dealer_i}][data-bid=#{perfect_bid}]").addClass('btn-outline-danger')

  go_back: (hand) ->
    if hand == 1
      $('div#play-area').fadeOut f_dur / 2, ->
        Main.setup()
    else
      # remove most recent bids, if they exist (as well as tricks and scores)
      for player in Main.game.players
        do (player) ->
          player.remove_bid(hand)
          player.remove_tricks(hand - 1)
          player.remove_score(hand - 1)
      ScoreSheet.remove_scores(hand - 1)
      Main.game.phase -= 1
      $('div#bid').fadeOut(f_dur / 2, Tricks.setup)

Tricks = 
  setup: ->
    dealer_i = Main.game.players.indexOf(Main.game.dealer())
    first_bid_i = (dealer_i + 1) % Main.game.num_players

    # deactivate submission button explicitly
    Tricks.tricks_valid = false
    $('button#tricks-submit').addClass('disabled')

    # determine the first player, which is the player who had the highest bid
    # first. Thus, the person who has the highest bid, but made that bid first
    leader_i = null
    max_bid = -1
    hand = Main.game.hand()
    for i in [first_bid_i..(first_bid_i + Main.game.num_players - 1)]
      do (i) ->
        j = i % Main.game.num_players
        player = Main.game.players[j]
        if player.get_bid(hand) > max_bid
          max_bid = player.get_bid(hand)
          leader_i = j
    leader = Main.game.players[leader_i]

    # update text for leader's name
    $('b#leader').text(leader.name)

    # nuke tricks buttons before rebuilding them
    $('#tricks-players').html('')
    
    # start with player just after dealer, which is coincidentally found at
    # index hand % number_of_players
    for i in [hand..(hand + Main.game.num_players - 1)]
      do (i) ->
        j = i % Main.game.num_players
        player = Main.game.players[j]
        to_insert = "<div class='row'>"
        to_insert += "<div class='col-4 col-md-5 vcenter'>"
        to_insert += "<h4>#{player.name}'s bid: #{player.get_bid(hand)}</h4>"
        to_insert += "</div><div class='col vcenter'>"
        to_insert += "<div class='btn-group mb-2' role='group' aria-label='#{player.name} bid'>"
        to_insert += "<button type=button data-player-i=#{j} data-success=1 class='btn btn-outline-success tricks-button'>Made It</button>"
        to_insert += "<button type=button data-player-i=#{j} data-success=0 class='btn btn-outline-danger tricks-button'>FAILED</button>"
        to_insert += "</div></div></div>"

        # add the button group and label to the DOM
        $(to_insert).appendTo('#tricks-players')

    # set up handlers for the tricks reporting buttons, but destroy any
    # existing handlers
    $('button.tricks-button').off('click')
    $('button.tricks-button').click ->
      self = this
      i = parseInt($(self).data('player-i'))
      player = Main.game.players[i]

      success = parseInt($(self).data('success'), 10)

      # mark button as active and actually set tricks in player object
      $("[data-player-i=#{i}]").removeClass('active')
      $(self).addClass('active')

      # design flaw: player was designed record actual amount of tricks, but
      # that is not needed. Rather than refactoring, report correct number
      # of tricks if bid was made, or else -1 (0 doesn't work since 0 is a
      # a valid bid)
      player.remove_tricks(hand)
      player.remove_score(hand)
      if success == 1
        player.set_tricks(hand, player.get_bid(hand))
      else
        player.set_tricks(hand, -1)

      player.update_score(hand)

      # Check to see if tricks are good to go
      valid = true
      # has each player made a bid?
      for player in Main.game.players
        do (player) ->
          valid = valid and player.tricks.length == hand
      Tricks.tricks_valid = valid

      if valid
        $('button#tricks-submit').removeClass('disabled')
      else
        $('button#tricks-submit').addClass('disabled')

    # set up listener for back button, but destroy any existing ones
    $('button#tricks-back').off('click')
    $('button#tricks-back').click ->
      Tricks.go_back Main.game.hand()


    # set up handler for confirmation button, but destroy any existing ones
    $('button#tricks-submit').off('click')
    $('button#tricks-submit').click (evt) ->
      evt.stopPropagation()
      evt.preventDefault()
      if Tricks.tricks_valid
        Main.game.phase += 1
        ScoreSheet.add_scores(hand)

        # account for if we just played the last hand (game over)
        if Main.game.over()
          # determine the winner or winners and display correct text on
          # endscreen
          winners = Main.game.winners()
          if winners.length == 1
            $('span#winner').text(winners[0].name)
          else if winners.length == 2
            $('span#winner').text("#{winners[0]} and #{winners[1]}")
          else
            res = ""
            for i in [0..(winners.length - 2)]
              do (i) ->
                res += "#{winners[i].name}, "
            res += "and #{winners[winners.length - 1].name}"
            $('span#winner').text(res)

          # button to set up a new game
          $('button#again').off('click')
          $('button#again').click ->
            $('div#endscreen').fadeOut(f_dur / 2)
            $('div#play-area').fadeOut(f_dur / 2, Main.setup)

          # actually show victory screen
          $('div#tricks').fadeOut(f_dur / 2, -> $('div#endscreen').fadeIn(f_dur / 2))            
        else
          # normal situation, just go back to bids for the next hand
          $('div#tricks').fadeOut(f_dur / 2, Bid.setup)
      else
        alert("Make sure all players have recorded outcomes of the hand.")

    $('#tricks').fadeIn(f_dur / 2)

  go_back: (hand) ->
    # remove most recent tricks and scores, if they exist. Definitely remove
    # previous bids to force setting them in bid view
    for player in Main.game.players
      do (player) ->
        player.remove_tricks(hand)
        player.remove_score(hand)
        player.remove_bid(hand)
    ScoreSheet.remove_bids(hand)
    Main.game.phase -= 1
    $('div#tricks').fadeOut(f_dur / 2, Bid.setup)

    
ScoreSheet =
  setup: ->
    html = '<table class="table table-sm table-striped">'
    html += '<thead><tr>'
    html += '<th scope="col" class="text-center">Hand</th>'
    for player in Main.game.players
      do (player) ->
        html += "<th scope='col' class='text-center'>#{player.name}</th>"
    html += '</tr></thead>'
    html += '<tbody id="scores">'
    html += '</tbody>'
    $('div#scoreboard').html(html)

  add_bids: (hand) ->
    row = "<tr data-hand=#{hand} class='bid-row'></tr>"
    $(row).hide().appendTo('tbody#scores')
    $("<th scope='row' class='text-center'>#{hand}</th>").appendTo("tr.bid-row[data-hand=#{hand}]")
    for player, i in Main.game.players
      do (player, i) ->
        $("<td class='text-center' data-hand=#{hand} data-player-i=#{i}>#{player.get_bid(hand)}</td>").appendTo("tr.bid-row[data-hand=#{hand}]")
    $("tr.bid-row[data-hand=#{hand}]").fadeIn(f_dur / 2)

  add_scores: (hand) ->
    row = "<tr data-hand=#{hand} class='score-row'></tr>"
    $(row).hide().appendTo('tbody#scores')
    $("<td></td>").appendTo("tr.score-row[data-hand=#{hand}]")
    for player, i in Main.game.players
      do (player, i) ->
        score = player.get_score(hand)
        extra_class='text-success'
        if score == 0 or (hand > 1 and score == player.get_score(hand - 1))
          extra_class='text-danger'
        $("<td class='text-center #{extra_class}' data-hand=#{hand} data-player-i=#{i}>#{score}</td>").appendTo("tr.score-row[data-hand=#{hand}]")
    $("tr.score-row[data-hand=#{hand}]").fadeIn(f_dur / 2)

  remove_bids: (hand) ->
    $("tr.bid-row[data-hand=#{hand}]").fadeOut(f_dur / 2, -> $("tr.bid-row[data-hand=#{hand}]").remove())

  remove_scores: (hand) ->
    $("tr.score-row[data-hand=#{hand}]").fadeOut(f_dur / 2, -> $("tr.score-row[data-hand=#{hand}]").remove())

$(document).ready ->
  Main.setup()