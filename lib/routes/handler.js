(function() {

  exports.routes = function(app) {
    app.get("/", function(req, res) {
      return res.render("register.jade", {});
    });
    app.get("/login", function(req, res) {
      return res.render("login.jade", {});
    });
    app.post("/login", function(req, res) {
      var password, username;
      res.render("login.jade", {});
      username = req.body.user_name;
      return password = req.body.password;
    });
    app.get("/register", function(req, res) {
      return res.render("register.jade", {});
    });
    return app.post("/register", function(req, res) {
      var cpass, email, gender, name, pass;
      res.render("register.jade", {});
      name = req.body.name;
      email = req.body.email;
      pass = req.body.pass;
      cpass = req.body.cpass;
      return gender = req.body.gender;
    });
  };

}).call(this);
