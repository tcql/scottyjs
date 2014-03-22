(function() {
  var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  window.Feed = (function() {
    function Feed() {
      this.render = __bind(this.render, this);
    }

    Feed.prototype.render = function(page, num_page) {
      if (page == null) {
        page = 1;
      }
      if (num_page == null) {
        num_page = 10;
      }
      return this.fetch(page, num_page, (function(_this) {
        return function(err, commits) {
          var phaser_commits;
          if (err) {

          } else {
            phaser_commits = commits;
            $("." + options.feed_class + " .loading").hide();
            return route.renderEach("templates/home/githubfeed.hb", phaser_commits).appendTo("." + options.feed_class + ".feed-table");
          }
        };
      })(this));
    };

    return Feed;

  })();

}).call(this);
