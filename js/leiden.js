var infoToggle = {
  setup: function() {
    $('.info-toggle a').click(function(link) {
      link.preventDefault();
      var target = $(this).parent('.info-toggle').data('target');
      var name = $(this).data('name');
      var description = $(this).data('description');
      // alert('target: ' + target + '\nname: ' + name + '\ndescription: ' + description);
      $(`[data-target='${target}']` + ' a.active').removeClass('active');
      $(this).addClass('active');
      $(target + " .name").fadeOut(function() {
        $(this).text(name);
      }).fadeIn();
      $(target + " .description").fadeOut(function() {
        $(this).html(description);
      }).fadeIn();
    })
  }
}

// var sideNav = {
//   setup: function() {
//     $('#side-nav .nav-link').click(function() {
//       $('#side-nav .nav-link').removeClass('active');
//       $(this).addClass('active');
//     });
//   }
// }

$( document ).ready(function() {  
  infoToggle.setup();
  // sideNav.setup();
});