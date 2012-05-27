express = require("express")
util = require("util")

passport = require("passport")
console.log process.env.NODE_ENV

# Application configuration
app = express.createServer()
app.configure ->
  app.set "views", __dirname + "/../views"
  app.set "view engine", "jade"
  app.use express.logger()
  app.use express.cookieParser()
  app.use express.bodyParser()
  app.use express.methodOverride()
  app.use express.session(secret: "keyboard cat")
  app.use passport.initialize()
  app.use passport.session()
  app.use app.router
  app.use express.static(__dirname + "/../public")

port = process.env.PORT or 5000
app.listen port, ->
  console.log "Listening on " + port

require("./routes/handler").routes app
