<!DOCTYPE html>
<html lang="en">
<head>
%from urllib import quote
%url = auth_hub_url+'htmllogin?code='+quote(code)+'&redirect_uri='+quote(redirect)
<title>
AuthHub Demo
</title>
  <script type="text/javascript" src="static/sha1.js"></script>
  <script type="text/javascript" src="static/totp.js"></script>
  <script type="text/javascript" src="static/jquery-2.1.4.min.js"></script>
  <script type="text/javascript">
    function update() {
      otp = get_totp_token('SF4TC2F7VRYMBQV5');
      $('#otp').text(otp);

      countdown = time_remaining();
      $('#time').text(countdown);
    }

    $(document).ready( function () {
      update();

      setInterval(update,500);
    });
  </script>
</head>
<body>
<h1>AuthHub Demo</h1>
<p>This is a demonstration of the AuthHub authentication service. The AuthHub service works similarly to OAuth in that the this demo site will
direct the end-user to log in at the AuthHub site. AuthHub authenticates the user using 2-factor authentication, and then redirects the user
back to the demo site with an authentication token. The demo site then uses that token to find the username of the authenticated end-user.</p>
<p>AuthHub will associate a username uniquely with an authenticated user. Authorization, additional user data, and any user preferences
can then be handled by sites using the AuthHub service in any way they please, and can be associated with the authenticated username. This
allows for a clean separation between authentication and authorization, and also separates user passwords databases from other databases
of potentially private information maintained by specific web sites.</p>
<p>In order to begin the login process, this demo server constructs a login url with a randomly generated code that is sent back by AuthHub in
order to avoid cross-site request forgery attacks, and a URI to which the browser should be redirected when login is complete. For this demo these
are as follows:</p>
<ul>
<li> <b>Code:</b> {{ code }}
<li> <b>Redirect URI:</b> {{ redirect }}
<li> <b>Login URL:</b> {{ url }}
</ul>
<p>You can log in to the test account using the following credentials:</p>
<ul>
<li> <b>Username:</b> testuser
<li> <b>Password:</b> password
<li> <b>MFA Code:</b> <span id="otp"></span> (updates in <span id="time"></span> seconds)
</ul>
<p>Click the link below in order to start the login process:<br/>
<a href="{{ url }}">Login</a></p>
</body>
</html>
