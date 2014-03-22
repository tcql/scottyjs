(function() {
  var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  window.HomePage = (function() {
    function HomePage(sammy) {
      this.routeIndex = __bind(this.routeIndex, this);
      var self;
      self = this;
      this.feeds = [
        new GithubFeed({
          feed_name: "Phaser Github Activity",
          feed_class: "phaser-github"
        }, "photonstorm", "phaser"), new GithubFeed({
          feed_name: "scotty.js Github Activity",
          feed_class: "scotty-github"
        }, "tchannel", "scottyjs")
      ];
      sammy.get('#/', function(context) {
        return self.routeIndex(context, this);
      });
    }

    HomePage.prototype.routeIndex = function(context, route) {
      return route.render('templates/home.hb').swap((function(_this) {
        return function() {
          route.renderEach("templates/home/feedrow.hb", _this.feeds).appendTo(".feeds");
          return _this.renderAllFeeds(_this.feeds, route);
        };
      })(this));
    };

    HomePage.prototype.renderAllFeeds = function(feeds, route) {
      var feed, _i, _len, _results;
      _results = [];
      for (_i = 0, _len = feeds.length; _i < _len; _i++) {
        feed = feeds[_i];
        _results.push(this.renderFeed(feed, route));
      }
      return _results;
    };

    HomePage.prototype.renderFeed = function(feed, route) {
      return feed.fetch(1, 20, function(err, results) {
        var msg;
        if (err) {
          msg = feed.parseError(err);
          return $("." + feed.options.feed_class + " .loading").html("There was an error retrieving the feed. " + msg);
        } else if (results.length === 0) {
          return $("" + feed.options.feed_class + " .loading").html("No activity.");
        } else {
          $("." + feed.options.feed_class + " .loading").hide();
          return route.renderEach("" + feed.template, results).appendTo("." + feed.options.feed_class + " .feed-table").then(function() {
            return $("." + feed.options.feed_class + " .feed-table .fade-in").addClass('fade-in-visible');
          });
        }
      });
    };

    return HomePage;

  })();

}).call(this);
