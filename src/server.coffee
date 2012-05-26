express = require("express")
util = require("util")
MemStore = express.session.MemoryStore
app = express.createServer(express.logger(), express.static(__dirname + "/public"))
app.configure ->
  app.set "views", __dirname + "/views"
  app.set "view engine", "jade"
  app.use express.bodyParser()
  app.use express.methodOverride()
  app.use app.router
  app.use express.static(__dirname + "/public")
  app.set "view options",
    layout: false

  app.register ".html",
    compile: (str, options) ->
      (locals) ->
        str

port = process.env.PORT or 5000
app.listen port, ->
  console.log "Listening on " + port

require("./routes/handler").routes app
