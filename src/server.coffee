express = require("express")
util = require("util")

app = express.createServer()
app.configure ->
  app.set "views", __dirname + "/../views"
  app.set "view engine", "jade"
  app.use express.logger()
  app.use express.cookieParser()
  app.use express.bodyParser()
  app.use express.methodOverride()
  app.use app.router
  app.use express.static(__dirname + "/../public")
  app.set "view options",
    layout: false

port = process.env.PORT or 4000
app.listen port, ->
  console.log "Listening on " + port

require("./routes/handler").routes app

