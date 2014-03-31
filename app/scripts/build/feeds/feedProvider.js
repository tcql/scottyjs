(function() {
  var FeedProvider, feed;

  feed = angular.module('scottyFeeds', []);

  FeedProvider = (function() {
    function FeedProvider() {
      this.registry = {
        "github": GithubFeed
      };
    }

    FeedProvider.prototype.make = function(type, options) {
      return new this.registry[type](options);
    };

    return FeedProvider;

  })();

  feed.factory('feedProvider', function($window) {
    return new FeedProvider;
  });

}).call(this);
