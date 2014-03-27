(function() {
  window.GithubFeed = (function() {
    function GithubFeed(options, user, repo) {
      this.options = options;
      this.user = user;
      this.repo = repo;
      this.template = 'templates/home/githubfeed.hb';
    }

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
      return scotty.api.repos.getCommits({
        user: this.user,
        repo: this.repo,
        page: page,
        per_page: num_per_page
      }, (function(_this) {
        return function(err, results) {
          var activity, commit, _i, _len;
          if (err) {
            return callback(err, null);
          }
          activity = [];
          for (_i = 0, _len = results.length; _i < _len; _i++) {
            commit = results[_i];
            activity.push(_this.makeRecord(commit));
          }
          return callback(null, activity);
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
