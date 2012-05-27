(function() {
  var app, express, port, util;

  express = require("express");

  util = require("util");

  app = express.createServer();

  app.configure(function() {
    app.set("views", __dirname + "/../views");
    app.set("view engine", "jade");
    app.use(express.logger());
    app.use(express.cookieParser());
    app.use(express.bodyParser());
    app.use(express.methodOverride());
    app.use(app.router);
    return app.use(express.static(__dirname + "/../public"));
  });

  port = process.env.PORT || 5000;

  app.listen(port, function() {
    return console.log("Listening on " + port);
  });

  require("./routes/handler").routes(app);

}).call(this);
