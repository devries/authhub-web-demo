#!/usr/bin/env python
import bottle
import requests
from beaker.middleware import SessionMiddleware
import random
import string

app = bottle.app()

# Configure session middleware, we are using simple file sessions
session_config = {
        "session.type": "file",
        "session.cookie_expires": True,
        "session.data_dir": "./session-data",
        "session.auto": True
    }

app = SessionMiddleware(app,session_config)

# Set redirect URL to your server. In this case we will run on port 8085 of
# localhost
redirect_url = 'http://localhost:8085/login'

# The base url for the AuthHub demo is
auth_hub_url = 'https://demo.authhub.net/'

@bottle.route('/')
def index():
    # Obtain a user_name if it is included in the session
    session = bottle.request.environ.get('beaker.session')
    
    username = session.get('username',None)

    if username is None:
        # In this case the user is not logged in

        # Create a code to guard against CSRF, store the code with the session
        # store and write it out to the login URL
        code = ''.join(random.choice(string.ascii_uppercase+string.digits) for x in range(64))
        session.invalidate()
        session['code'] = code
        session.save()

        return bottle.template('login_page', auth_hub_url=auth_hub_url, 
                code=code, redirect=redirect_url)
    else:
        return bottle.template('logout_page',username=session.get('username'))

@bottle.route('/logout')
def logout():
    # We will just get rid of session information and redirect to the root page
    session = bottle.request.environ.get('beaker.session')
    session.delete()

    bottle.redirect('/')

@bottle.route('/login')
def login():
    session = bottle.request.environ.get('beaker.session')
    query_params = bottle.request.query.decode()

    # I compare the CSRF codes from the session and the query parameters. If they are both
    # missing I don't want them to match on None==None, so I set different values for them.
    code = query_params.get('code', 'querynull')
    if session.get('code', 'sessionnull')==code:
        code_match = True

        # In addition to the CSRF code, a token will be returned by the redirect, which I
        # will verify with a GET request to the token verification API.
        token = query_params.get('token','')
        r = requests.get(auth_hub_url+'verify/'+token,cert=('authhub_demo_client.crt', 'authhub_demo_client.key'))
        response = r.json()

        token_success = response.get('valid',False)
        username = response.get('username','NULL')
        if token_success:
            session['username'] = username
            r2 = requests.get(auth_hub_url+'revoke/'+token,cert=('authhub_demo_client.crt', 'authhub_demo_client.key')) # revoke token right away
    else:
        code_match = False
        token_success = False
        username = 'NULL'

    return bottle.template('verification_page',code=code,token=token,code_match=str(code_match),token_success=str(token_success),username=str(username))

@bottle.route('/static/<filename:path>')
def send_static(filename):
    response = bottle.static_file(filename,root='./static')
    return response

if __name__=='__main__':
    bottle.debug(True)
    bottle.run(app=app,host='127.0.0.1',port=8085)
