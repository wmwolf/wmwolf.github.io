var fileInfo = {
  setup: function() {

    $("#workdir-files a").click(function() {
      // file_link.preventDefault();
      $('#workdir-files a.active').toggleClass('active');
      $(this).toggleClass('active');
      var name = $(this).data('name');
      var description = $(this).data('description');
      $("#file-name").fadeOut(function() {
        $('#file-name').text(name);
      }).fadeIn();
      $("#file-description").fadeOut(function() {
        $('#file-description').html(description);
      }).fadeIn();
    });
  }
};

$( document ).ready(function() {
  fileInfo.setup();
});