ensureAuthenticated = require("./passport-helpers").ensureAuthenticated
passport = require("./passport-helpers").passport

exports.routes = (app) ->
  ###=============###
  #  Get Handling   #
  ###=============###
  # Check if user is already authenticated.
  app.get "/", (req, res) ->
    res.redirect "/login"

  # Login and register From getter
  app.get "/login", (req, res) ->
    res.render "login",
      user: req.user,
      message: req.flash('error') 

  app.get "/register", (req, res) ->
    res.render "register", 
      user: req.user

  app.get "/account", ensureAuthenticated, (req, res) ->
    res.render "account",
      user: req.user

  # Log-out function
  app.get "/logout", (req, res) ->
    req.logout()
    res.redirect "/"

  ###=============###
  #  Post Handling   #
  ###=============###
  app.post "/register", (req, res) ->
    res.render "register.jade", {}
    name = req.body.name
    email = req.body.email
    pass = req.body.pass
    cpass = req.body.cpass
    gender = req.body.gender

  # POST /login
  #   Use passport.authenticate() as route middleware to authenticate the request. 
  #   If authentication fails, the user will be redirected back to the login page.
  #   Otherwise, the user is redirected to his personal home page
  #
  #   Test this function from terminal using:
  #     curl -v -d "username=bob&password=secret" http://127.0.0.1:5000/login
  app.post "/login", (req, res, next) ->
    passport.authenticate("local", (err, user, info) ->
      return next(err)  if err
      unless user
        # user is not authenticated, redirect to /login
        req.flash "error", "Failed"
        return res.redirect("/login")
      req.logIn user, (err) ->
        # user is authenticated, redirect to /users/user.username
        return next(err)  if err
        res.redirect "/users/" + user.username
    ) req, res, next
