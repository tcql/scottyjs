(function() {
  window.GithubFeed = (function() {
    function GithubFeed(options) {
      if (options == null) {
        options = {};
      }
      this.errorMessage = null;
      this.latestResults = [];
      this.fetching = false;
      this.setUp(options);
    }

    GithubFeed.prototype.setUp = function(options) {
      this.name = options.name;
      this.user = options.user;
      return this.repo = options.repo;
    };

    GithubFeed.prototype.fetch = function(page, num_per_page, callback) {
      if (page == null) {
        page = 1;
      }
      if (num_per_page == null) {
        num_per_page = 10;
      }
      if (callback == null) {
        callback = function() {};
      }
      this.fetching = true;
      return scotty.api.repos.getCommits({
        user: this.user,
        repo: this.repo,
        page: page,
        per_page: num_per_page
      }, (function(_this) {
        return function(err, results) {
          var commit, _i, _len;
          _this.fetching = false;
          _this.errorMessage = null;
          _this.latestResults.splice(0);
          if (err) {
            _this.errorMessage = _this.parseError(err);
            return callback(err, null);
          }
          for (_i = 0, _len = results.length; _i < _len; _i++) {
            commit = results[_i];
            _this.latestResults.push(_this.makeRecord(commit));
          }
          return callback(null, _this.latestResults);
        };
      })(this));
    };

    GithubFeed.prototype.parseError = function(error) {
      var e;
      try {
        return $.parseJSON(error.message).message;
      } catch (_error) {
        e = _error;
        return error;
      }
    };

    GithubFeed.prototype.makeRecord = function(result) {
      return {
        icon: result.author.avatar_url,
        icon_link: result.author.html_url,
        author: result.author.login,
        date: moment(result.commit.committer.date).format('YYYY-MM-DD HH:MM'),
        message: result.commit.message,
        link: result.html_url
      };
    };

    return GithubFeed;

  })();

}).call(this);
