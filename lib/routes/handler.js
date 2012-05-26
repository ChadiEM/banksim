
exports.routes = function(app) {
  app.get("/", function(req, res) {
    return res.render("register.html", {});
  });
  app.post("/login", function(req, res) {
    return res.render("login.html", {});
  });
  app.get("/login", function(req, res) {
    return res.render("login.html", {});
  });
  app.get("/register", function(req, res) {
    return res.render("register.html", {});
  });
  return app.post("/register", function(req, res) {
    return res.render("register.html", {});
  });
};
