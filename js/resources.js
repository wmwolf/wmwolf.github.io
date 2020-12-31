$(document).ready(function() {
  $('#physics_211').fadeIn(200);
  $('#physics_211-nav').click(function() {
    $('#physics_211-nav').addClass('active');
    $('.field').not('#physics_211').fadeOut(200, function() {
      $('#physics_211').fadeIn(200);
    });
  });
  $('#physics_211 #1d_kinematics a').click(function() {
    $('#physics_211 #1d_kinematics i').toggleClass('fa-angle-right');
    $('#physics_211 #1d_kinematics i').toggleClass('fa-angle-down');
    $('#physics_211 #1d_kinematics .initially-hidden').slideToggle(200);
  });
  $('#physics_211 #momentum a').click(function() {
    $('#physics_211 #momentum i').toggleClass('fa-angle-right');
    $('#physics_211 #momentum i').toggleClass('fa-angle-down');
    $('#physics_211 #momentum .initially-hidden').slideToggle(200);
  });
  });
