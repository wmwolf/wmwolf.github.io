var infoToggle = {
  setup: function() {
    var fadeDuration = 200;
    $('.info-toggle a').click(function(link) {
      link.preventDefault();
      var target = $(this).parent('.info-toggle').data('target');
      var name = $(this).data('name');
      var description = $(this).data('description');
      // alert('target: ' + target + '\nname: ' + name + '\ndescription: ' + description);
      $(`[data-target='${target}']` + ' a.active').removeClass('active');
      $(this).addClass('active');
      $(target + " .name").fadeOut(fadeDuration, function() {
        $(this).text(name);
      }).fadeIn(fadeDuration);
      $(target + " .description").fadeOut(fadeDuration, function() {
        $(this).html(description);
      }).fadeIn(fadeDuration);
    });
  }
};

var rng = {
  setup: function() {
    $('#mdot-gen').click(function() {
      // alert('clicked');
      var mdot_min = 3.1;
      var mdot_max = 3.7;
      var new_base = (mdot_min + Math.random() * (mdot_max - mdot_min)).toPrecision(3);
      $('span.mdot-base').text(new_base);
    });
  }
};

var quizQuestions = {
  setup: function() {
    $('.quiz-option').click(function() {
      self = $(this);
      $(self.data('group')).collapse('hide');
      if (self.data('quiz-correct')) {
        self.removeClass('btn-primary');
        self.addClass('btn-success');
      } else {
        self.removeClass('btn-primary');
        self.addClass('btn-danger');        
      }

    })
  }
}

// var sideNav = {
//   setup: function() {
//     $('.part-header').click(function() {
//       window.location.href = $(this).attr('href');
//       $(this).data('target').removeClass('active');
//       $('#leiden-instructions').scrollspy('refresh');
//     });
//   }
// };


$( document ).ready(function() {  
  infoToggle.setup();
  rng.setup();
  $('[data-toggle="tooltip"]').tooltip()
  quizQuestions.setup();
  // sideNav.setup();
  // alert('done with sideNav setup');
});