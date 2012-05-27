# Below are some helper functions that are used to make sure
# the user is authenticated correctly

# passport management import
passport = require("passport")
LocalStrategy = require("passport-local").Strategy


# passport helper functions
findById = (id, fn) ->
  idx = id - 1
  if users[idx]
    fn null, users[idx]
  else
    fn new Error("User " + id + " does not exist")

findByUsername = (username, fn) ->
  i = 0
  len = users.length

  while i < len
    user = users[i]
    return fn(null, user)  if user.username is username
    i++
  fn null, null

users = [
  id: 1
  username: "bob"
  password: "secret"
  email: "bob@example.com"
,
  id: 2
  username: "joe"
  password: "birthday"
  email: "joe@example.com"
 ]

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
      unless user.password is password
        return done(null, false,
          message: "Invalid password"
        )
      done null, user
)


exports.passport = passport

# Simple route middleware to ensure user is authenticated.
#   Use this route middleware on any resource that needs to be protected.  If
#   the request is authenticated (typically via a persistent login session),
#   the request will proceed.  Otherwise, the user will be redirected to the
#   login page.
exports.ensureAuthenticated = (req, res, next) ->
  return next()  if req.isAuthenticated()
  res.redirect "/login"

