var quiz = {
  update_math: function() {
    MathJax.Hub.Queue(["Typeset", MathJax.Hub]);
  },
  QuizItem: function (q_title, question, opts, exps, correct_index, image=undefined, cap=undefined) {
    this.q_title = q_title;
    this.question = question;
    this.opts = opts;
    this.exps = exps;
    this.correct_index = correct_index;
    this.image = image;
    this.cap = cap;
    this.answered_correctly = false;
    this.answered_incorrectly = false;
    this.active = false;
    this.check = function(guess) {
      return (this.correct_index === guess);
    };
    this.restyle_nav = function() {
      // first find this nav
      var this_nav = ''
      var this_title = this.q_title
      $('#questions-nav .list-group-item').each(function(i, elt) {
        if ($(elt).text() == this_title) {
          this_nav = $(elt);
        }
      });

      // strip everything if active and just set active
      if (this.active) {
        $(this_nav).removeClass('bg-success');
        $(this_nav).removeClass('bg-danger');
        $(this_nav).addClass('active');
      } else {
        $(this_nav).removeClass('active');
        if (this.answered_correctly) {
          $(this_nav).addClass('bg-success');
          $(this_nav).addClass('text-white');
          $(this_nav).removeClass('bg-danger');
        } else if (this.answered_incorrectly) {
          $(this_nav).removeClass('bg-success');
          $(this_nav).addClass('bg-danger');
          $(this_nav).addClass('text-white');
        } else {
          $(this_nav).removeClass('bg-success');
          $(this_nav).removeClass('bg-danger');
        }
      }
    },
    this.change_result = function(outcome, explanation) {
      this.change_outcome(outcome);
      this.change_explanation(outcome, explanation);
    };
    this.change_outcome = function(outcome) {
      var duration = 50
      if ($('#result').is('visible')) {
        duration = 400
      }
      $('#outcome').fadeOut(duration, function() {
        $('#outcome').text(outcome);
        if (outcome == "Correct") {
          $('#outcome').parent().removeClass('bg-primary')          
          $('#outcome').parent().removeClass('bg-danger')
          $('#outcome').parent().addClass('bg-success')
        } else {
          $('#outcome').parent().removeClass('bg-primary')          
          $('#outcome').parent().removeClass('bg-success')
          $('#outcome').parent().addClass('bg-danger')
          $('#next').hide();
        }
      }).fadeIn(function() {
        $('#result').slideDown(function() {
          if (outcome === 'Correct') {
            $('#next').fadeIn();
          }
        });
      });
    };
    this.change_explanation = function(outcome, explanation) {
      var duration = 50
      if ($('#result').is('visible')) {
        duration = 400
      }
      $('#explanation').fadeOut(duration, function() {
        $('#explanation').html(explanation);
        if (outcome == "Correct") {
          $('#result div.card').removeClass('border-danger');
          $('#result div.card-body').removeClass('text-danger');
          $('#result div.card').addClass('border-success');
          $('#result div.card-body').addClass('text-success');
        } else {
          $('#result div.card').removeClass('border-success');
          $('#result div.card-body').removeClass('text-success');
          $('#result div.card').addClass('border-danger');
          $('#result div.card-body').addClass('text-danger');
        }
      }).fadeOut(1, quiz.update_math).fadeIn();

    }
    this.answer_wrong = function(opt) {
      var exp = this.exps[opt];
      this.change_result("Incorrect", exp);
      this.answered_correctly = false;
      this.answered_incorrectly = true;
      // Cue outcome in options with color classes
      $('#options-' + opt).removeClass('btn-outline-primary');
      $('#options-' + opt).addClass('btn-outline-danger');  
    };
    this.answer_right = function() {
      var opt = this.correct_index;
      var exp = this.exps[opt];
      this.change_result("Correct", exp);
      this.answered_incorrectly = false;
      this.answered_correctly = true;     
      // Cue outcome in options with color classes
      $('#options-' + opt).removeClass('btn-outline-primary');
      $('#options-' + opt).addClass('btn-outline-success');
    };
    this.set_question = function() {
      // restyle incoming nav
      this.active = true;
      this.restyle_nav();

      // hide everything, set it up, then fade everything in
      var opts = this.opts;
      
      
      this.active = true;
      this_quiz_item = this;
      var adjust = $('#quiz-global').fadeOut(function() {
        $('#q_title').text(this_quiz_item.q_title);
        $('#question').html(this_quiz_item.question);
        $('#result').hide();
        $('#options').html('');
        $('#outcome').text('');
        $('#explanation').html('');        
        $('#next').hide();
        var options_to_add = ''
        for (opt in opts) {
          options_to_add = options_to_add + '<button type="button" id="options-' + opt + '" class="btn btn-outline-primary btn-lg">' + opts[opt] + "</button>"
        }
        $('#options').html(options_to_add);
        for (var i = 0; i <= opts.length - 1; i++) {
          $('#options-' + i).click(quiz.getAnswerHandler(this_quiz_item, i));
        }
      }).fadeOut(1, quiz.update_math).fadeIn();
    };
  },
  navs: function() {
    return $('questions-nav a');
  },
  getAnswerHandler: function(quiz_item, opt) {
    return function() {
      if (quiz_item.check(opt)) {
        quiz_item.answer_right(quiz_item.exps[quiz_item.correct_index]);
      } else {
        quiz_item.answer_wrong(opt, quiz_item.exps[opt]);
      }
    };      
  },
  clear_question: function(after) {
    $('#quiz-global').fadeOut(function() {
      $('#q_title').text('');
      $('#question').empty();
      $('#options').empty();
      $('#result').empty()
      $('#outcome').empty();
      $('#explanation').empty();
      $('#next').hide();
      after();
    }).fadeIn();
  },
  already_done: function(quiz_items) {
    var res = true;
    for (var i = quiz_items.length - 1; i >= 0; i--) {
      res = (res & quiz_items[i].answered_correctly)
    }
    return res
  },
  run_quiz: function(quiz_items) {
    var i = 0;
    quiz_items[0].set_question();
    $('#next').click(function() {
      // restyle nav for outgoing question
      quiz_items[i].active = false;
      quiz_items[i].restyle_nav();
      if (!quiz.already_done(quiz_items)) {
        while (quiz_items[i].answered_correctly) {
          i = (i + 1) % quiz_items.length
        }
        quiz_items[i].set_question();
      } else {
        quiz.clear_question(function() {
          $('#q_title').text("You have successfully completed this quiz.");
        });
      }
    });
    $('#questions-nav .list-group-item').click(function() {
      // restyle nav for outgoing question
      quiz_items[i].active = false;
      quiz_items[i].restyle_nav();
      i = $(this).data('position');
      quiz_items[i].set_question();
    })
  },
  shuffle: function(array) {
    var currentIndex = array.length, temporaryValue, randomIndex;

    // While there remain elements to shuffle...
    while (0 !== currentIndex) {

      // Pick a remaining element...
      randomIndex = Math.floor(Math.random() * currentIndex);
      currentIndex -= 1;

      // And swap it with the current element.
      temporaryValue = array[currentIndex];
      array[currentIndex] = array[randomIndex];
      array[randomIndex] = temporaryValue;
    }

    return array;
  }
};
