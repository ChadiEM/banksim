exports.routes = (app) ->
  app.get "/", (req, res) ->
    res.render "register.jade", {}

  # Login handling
  app.get "/login", (req, res) ->
    res.render "login.jade", {}

  app.post "/login", (req, res) ->
    res.render "login.jade", {}
    username = req.body.user_name
    password = req.body.password

  # Registration handling
  app.get "/register", (req, res) ->
    res.render "register.jade", {}

  app.post "/register", (req, res) ->
    res.render "register.jade", {}
    name = req.body.name
    email = req.body.email
    pass = req.body.pass
    cpass = req.body.cpass
    gender = req.body.gender
