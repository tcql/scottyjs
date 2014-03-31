(function() {
  var NewsController, controllers;

  controllers = angular.module('homeControllers', ['scottyFeeds']);

  NewsController = (function() {
    function NewsController($scope, feedProvider) {
      this.scope = $scope;
      $scope.feeds = [
        feedProvider.make("github", {
          name: "Phaser Github Activity",
          user: "photonstorm",
          repo: "phaser"
        }), feedProvider.make("github", {
          name: "scotty.js Github Activity",
          user: "tchannel",
          repo: "scottyjs"
        })
      ];
      this.refresh();
    }

    NewsController.prototype.refresh = function() {
      var feed, _i, _len, _ref, _results;
      _ref = this.scope.feeds;
      _results = [];
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        feed = _ref[_i];
        _results.push(feed.fetch(1, 10, (function(_this) {
          return function(err, results) {
            return _this.scope.$apply();
          };
        })(this)));
      }
      return _results;
    };

    return NewsController;

  })();

  controllers.controller('Home.NewsController', ['$scope', 'feedProvider', NewsController]);

}).call(this);
