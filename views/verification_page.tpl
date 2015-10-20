<!DOCTYPE html>
<html lang="en">
<head>
<title>
AuthHub Demo
</title>
</head>
<body>
<h1>Verification</h1>
<p>Now redirected back from AuthHub. The demo site receives the cross-site request forgery prevention code it originally sent,
as well as a token which it can verify with the AuthHub server. These are:</p>
<ul>
<li> <b>Code: </b> {{ code }}
<li> <b>Token: </b> {{ token }}
</ul>
<p>First, the server checks that the code matches the code it sent (generally some session state is used to manage the code).
The indicator below should tell us if the cross-site request forgery code returned matches the one that was sent:
</p> 
<ul>
<li> Code matches: {{ code_match }}
</ul>
<p>Second, the demo site sends a call back to the server, querying the token it received. If the token is valid, it should
receive a successful verification response along with a username. These are shown below.</p>
<ul>
<li> Token Verified: {{ token_success }}
<li> Username Found: {{ username }}
</ul>
<p>Third, the demo site sends an invalidation request back to AuthHub on the token. Unlike OAuth tokens which are used to
make several calls to an API, the AuthHub token is only used to verify a login account, and revoking it after use is good
practice. You can see this effect by reloading this page. If you reload the page the token verification step will no
longer return "True", however you are already logged into the site, so this will not destroy your existing session.</p>
<p>The demo app is now free to save the username as a session variable, and use that username as it sees fit. Click the link
below to move on.<br/>
<a href="/">Main Page</a></p>
</body>
</html>
