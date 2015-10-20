<!DOCTYPE html>
<html lang="en">
<head>
<title>
AuthHub Demo
</title>
</head>
<body>
<h1>You are Logged In</h1>
<p>A logged in user can then go about their business on the page. You have been logged in with the following
credential</p>
<ul>
<li> <b>username: </b> {{ username }}
</ul>
<p>Note that AuthHub only asserts that the user using the demo site is uniquely identified by that username. No
further assertions regarding the identity of the user (for example an email address, or name) are guaranteed
by AuthHub. Other OAuth services often make many identity claims, however email can be hacked, and names are often
not verified. Usually it is enough to uniquely associate a user to a particular username in order for a site
to provide good functionality.</p>
<p>To log out click the link below<br/>
<a href="/logout">Logout</a></p>
</body>
</html>
