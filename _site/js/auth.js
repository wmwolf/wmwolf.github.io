var auth = {
  authenticate: function(username, password) {
    return (username == auth.username) && (password == auth.password);
  },
  wait_for_submission: function() {
    $('#login-submit').on('click', function(event) {
      event.preventDefault();
      var form_data = $('#login-form').serializeArray();
      var password = undefined;
      var username = undefined;
      for (var i = form_data.length - 1; i >= 0; i--) {
        if (form_data[i]['name'] == 'username') {
          username = form_data[i]['value'];
        } else if (form_data[i]['name'] == 'password') {
          password = form_data[i]['value'];
        }
      }
      if (auth.authenticate(username, password)) {
        window.location = "/teaching/resources/" + auth.prefix;    
        // window.location.replace('/resources/' + auth.prefix + '/index.html');
      } else {
        alert("Invalid credentials. Are you using an up-to-date username and password?");
      }
    });
  },
  username: 'student',
  password: 'Blu1sMyHomeboy',
  prefix: 'covid-19'  
}

$(document).ready(function() {
  auth.wait_for_submission();
});
