# Below are some helper functions that are used to make sure
# the user is authenticated correctly

# passport management import
passport = require("passport")
LocalStrategy = require("passport-local").Strategy

User = require("../models/user").User

# Finds if a user with this id exists in the database
findById = (id, fn) ->
  User.find
    _id: id
  , (err, users) ->
    if users[0]
      fn null, users[0]
    else
      fn err, null

# Finds if user username exists in the database
findByUsername = (username, fn) ->
  User.find
    name: username
  , (err, users) ->
    if users[0]
      fn null, users[0]
    else
      fn err, null

# passport helper functions
passport.serializeUser (user, done) ->
  done null, user.id

passport.deserializeUser (id, done) ->
  findById id, (err, user) ->
    done err, user

passport.use new LocalStrategy((username, password, done) ->
  process.nextTick ->
    findByUsername username, (err, user) ->
      return done(err)  if err
      unless user
        return done(null, false,
          message: "Unkown user " + username
        )
      unless user.pass is password
        return done(null, false,
          message: "Invalid password"
        )
      done null, user
)


# The passport instance
exports.passport = passport

# Simple route middleware to ensure user is authenticated.
#   Use this route middleware on any resource that needs to be protected.  If
#   the request is authenticated (typically via a persistent login session),
#   the request will proceed.  Otherwise, the user will be redirected to the
#   login page.
exports.ensureAuthenticated = (req, res, next) ->
  return next()  if req.isAuthenticated()
  res.redirect "/login"


# A function that will take the request and add the user to the database IF
# that user does not exist yet in the db.
exports.register = (req, cb) ->
  User.find
    name: req.body.name
  , (err, users) ->
    if users[0]
      cb(null, err)
    else
      # Create the basic user information
      user = new User
      user.name = req.body.name
      user.email = req.body.email
      user.pass = req.body.pass
      user.gender = req.body.gender

      # Create a default account for the user
      account = []
      user.accounts.push(account)
      user.save (err) ->
        cb(user, err)
