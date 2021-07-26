AuthHub Web Demo
================

| :warning: WARNING                                               |
|:----------------------------------------------------------------|
| This repository is archived. The project has been discontinued. |

This is a demonstration of how to use the AuthHub authentication service with
python, requests, and the bottle microframework. Other frameworks will be just
as easy. When following the instructions below, I show the prompt of the
system as a `$` character which should not be typed along with the command.

Installation
------------

To install, you should have `python` 2.7 and `pip` already installed. I also
recommend using `virtualenv`. Check out the sample code, and change into the
directory. Start by creating a virtual environment and
activating it using the commands:

    $ virtualenv venv
    $ source venv/bin/activate

Next you can install the required python packages using the command below.

    $ pip install -r requirements.txt

Running the Server
------------------

You can now run the sample server using the command below.

    $ python main_app.py

This will create a web service listening at `http://localhost:8085/`. This
page will explain step-by-step the processes by which it uses the AuthHub demo
server at `https://demo.authhub.net/` to facilitate a login. The details are
also explained below.

Using AuthHub
-------------

Using AuthHub involves several steps and is quite similar to using OAuth2. It
is a little more secure in that it does not rely only on a token remaining
secure, but also uses client certificate authentication when communicating
between the application server and the authentication server. More details
about the technologies involved are on [my
blog](https://idolstarastronomer.com/authhub-part-1.html). The steps to login
using AuthHub are:

1. Generate a code to prevent cross-site request forgery (CSRF).
2. Create a login link to AuthHub which sends the cross-site request code and
a redirect URL via URL parameters.
3. The user will enter credentials at AuthHub, if successful the user will be
redirected back to your server via the redirect URL.
4. The redirect back to your web server will include, on a successful login, a
token to use in identifying the user, the CSRF code you sent earlier, and the
time at which that token expires.
5. Your server verifies using sessions or cookies that the CSRF code it
received is the same one it sent with the user.
5. Your server verifies the token it received with AuthHub and obtains the
username of the authenticated user.
6. Your server revokes the token it received.

Detailed instructions about each of these steps are [documented in the
blog](https://idolstarastronomer.com/authhub-part-2.html) and demonstrated in
python in the `main_app.py` program.

Acknowledgments
---------------

In order to provide multi-factor authentication tokens for the `testuser`
account I make use of the [jQuery](http://jquery.com/) library as well as the
[jsSHA](http://caligatio.github.io/jsSHA/) library. These are located in the
`static` directory.
