(function() {
  process.on("uncaughtException", function(err) {
    return console.log(err);
  });

}).call(this);
