(function() {
  var LocalStrategy, findById, findByUsername, passport, users;

  passport = require("passport");

  LocalStrategy = require("passport-local").Strategy;

  findById = function(id, fn) {
    var idx;
    idx = id - 1;
    if (users[idx]) {
      return fn(null, users[idx]);
    } else {
      return fn(new Error("User " + id + " does not exist"));
    }
  };

  findByUsername = function(username, fn) {
    var i, len, user;
    i = 0;
    len = users.length;
    while (i < len) {
      user = users[i];
      if (user.username === username) return fn(null, user);
      i++;
    }
    return fn(null, null);
  };

  users = [
    {
      id: 1,
      username: "bob",
      password: "secret",
      email: "bob@example.com"
    }, {
      id: 2,
      username: "joe",
      password: "birthday",
      email: "joe@example.com"
    }
  ];

  passport.serializeUser(function(user, done) {
    return done(null, user.id);
  });

  passport.deserializeUser(function(id, done) {
    return findById(id, function(err, user) {
      return done(err, user);
    });
  });

  passport.use(new LocalStrategy(function(username, password, done) {
    return process.nextTick(function() {
      return findByUsername(username, function(err, user) {
        if (err) return done(err);
        if (!user) {
          return done(null, false, {
            message: "Unkown user " + username
          });
        }
        if (user.password !== password) {
          return done(null, false, {
            message: "Invalid password"
          });
        }
        return done(null, user);
      });
    });
  }));

  exports.passport = passport;

  exports.ensureAuthenticated = function(req, res, next) {
    if (req.isAuthenticated()) return next();
    return res.redirect("/login");
  };

}).call(this);
