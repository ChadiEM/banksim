exports.routes = (app) ->
  app.get "/", (req, res) ->
    res.render "register.html", {}

  app.post "/login", (req, res) ->
    res.render "login.html", {}

  app.get "/login", (req, res) ->
    res.render "login.html", {}

  app.get "/register", (req, res) ->
    res.render "register.html", {}

  app.post "/register", (req, res) ->
    res.render "register.html", {}
