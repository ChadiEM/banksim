ensureAuthenticated = require("./passport-helpers").ensureAuthenticated
passport = require("./passport-helpers").passport
register = require("./passport-helpers").register
deposit =  require("./passport-helpers").deposit
withdraw =  require("./passport-helpers").withdraw

exports.routes = (app) ->
  #### Get Handling
  # Check if user is already authenticated.
  app.get "/", ensureAuthenticated, (req, res, next) ->
    res.redirect "/users/" + req.user.name

  # Login and register Form getter
  app.get "/login", (req, res) ->
    res.render "login",
      title: "Login",
      logo: 1,
      user: req.user,
      message: req.flash('error') 

  app.get "/register", (req, res) ->
    res.render "register", 
      title: "Register",
      logo: 1,
      user: req.user,
      message: req.flash('error') 

  # Handling of the user's homepage
  app.get "/users/:name", ensureAuthenticated, (req, res) ->
    res.render "home", 
      title: "Home",
      logo: 0,
      user: req.user,
      message: req.flash('error') ,
      transactions: req.user.accounts[0].transactions

  # Log-out function
  app.get "/logout", (req, res) ->
    req.logout()
    res.redirect "/"


  #### Post Handling
  app.post "/withdraw", ensureAuthenticated, (req, res, next) ->
    withdraw req, (err) ->
      req.flash "error", "Failed" if err
      req.flash "error", "Success" if !err
      res.redirect "/users/" + req.user.name

  app.post "/deposit", ensureAuthenticated, (req, res, next) ->
    deposit req, (err) ->
      req.flash "error", "Failed" if err
      req.flash "error", "Success" if !err
      res.redirect "/users/" + req.user.name


  app.post "/register", (req, res, next) ->
    register req, (user, err) ->
      if user is null
        # user is not authenticated, redirect to /register
        req.flash "error", "Already-Exist"
        return res.redirect("/register")
      else
        req.logIn user, (err) ->
          return next(err)  if err
          res.redirect "/users/" + user.name

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
        res.redirect "/users/" + user.name
    ) req, res, next
