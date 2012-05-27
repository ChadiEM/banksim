(function() {
  var ensureAuthenticated, passport;

  ensureAuthenticated = require("./passport-helpers").ensureAuthenticated;

  passport = require("./passport-helpers").passport;

  exports.routes = function(app) {
    /*=============
    */
    /*=============
    */    app.get("/", function(req, res) {
      return res.redirect("/login");
    });
    app.get("/login", function(req, res) {
      return res.render("login", {
        user: req.user,
        message: req.flash('error')
      });
    });
    app.get("/register", function(req, res) {
      return res.render("register", {
        user: req.user
      });
    });
    app.get("/account", ensureAuthenticated, function(req, res) {
      return res.render("account", {
        user: req.user
      });
    });
    app.get("/logout", function(req, res) {
      req.logout();
      return res.redirect("/");
    });
    /*=============
    */
    /*=============
    */
    app.post("/register", function(req, res) {
      var cpass, email, gender, name, pass;
      res.render("register.jade", {});
      name = req.body.name;
      email = req.body.email;
      pass = req.body.pass;
      cpass = req.body.cpass;
      return gender = req.body.gender;
    });
    return app.post("/login", function(req, res, next) {
      return passport.authenticate("local", function(err, user, info) {
        if (err) return next(err);
        if (!user) {
          req.flash("error", "Failed");
          return res.redirect("/login");
        }
        return req.logIn(user, function(err) {
          if (err) return next(err);
          return res.redirect("/users/" + user.username);
        });
      })(req, res, next);
    });
  };

}).call(this);
