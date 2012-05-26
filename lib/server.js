var MemStore, app, express, port, util;

express = require("express");

util = require("util");

MemStore = express.session.MemoryStore;

app = express.createServer(express.logger(), express.static(__dirname + "/public"));

app.configure(function() {
  app.set("views", __dirname + "/views");
  app.set("view engine", "jade");
  app.use(express.bodyParser());
  app.use(express.methodOverride());
  app.use(app.router);
  app.use(express.static(__dirname + "/public"));
  app.set("view options", {
    layout: false
  });
  return app.register(".html", {
    compile: function(str, options) {
      return function(locals) {
        return str;
      };
    }
  });
});

port = process.env.PORT || 5000;

app.listen(port, function() {
  return console.log("Listening on " + port);
});

require("./routes/handler").routes(app);
