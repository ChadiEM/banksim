# Initialization
mongoose = require("mongoose")
nconf = require("nconf")
nconf.use "file",
  file: "config.json"
nconf.load()

# Variable that contains the remote database settings
settings = nconf.get("db")

configure = () ->
  # The location of the db is defined based on the environment
  if process.env.NODE_ENV is "production"
    db_path = "mongodb://" + settings.username + ":" + settings.pass + "@" + settings.host + ":" + settings.port + "/" + settings.name
  else
    db_path = "mongodb://localhost/banksim"

  mongoose.connect db_path

  module.exports = mongoose.createConnection(db_path)

# Function that will add the config options related to the db object
confInit = ( )->
  nconf.set "db:username", "root"
  nconf.set "db:pass", "k9jFP48Vqx21b2c"
  nconf.set "db:host", "staff.mongohq.com"
  nconf.set "db:port", "10048"
  nconf.set "db:name", "banksim"
  nconf.save (err) ->
    if err
      console.error err.message
      return
    console.log "Configuration saved successfully."
    settings = nconf.get("db")
    configure()


# If settings is undefined, then the config entry for the db was not created.
# We will thus invoke the function that creates it
if settings
  configure()
else
  confInit()

