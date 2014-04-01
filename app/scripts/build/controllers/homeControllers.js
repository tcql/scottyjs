(function() {
  var controllers;

  controllers = angular.module('homeControllers', ['scottyFeeds']);

  controllers.controller('Home.MainController', [
    '$scope', 'feedProvider', function($scope, feedProvider) {
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
      $scope.refresh = function() {
        var feed, _i, _len, _ref, _results;
        _ref = $scope.feeds;
        _results = [];
        for (_i = 0, _len = _ref.length; _i < _len; _i++) {
          feed = _ref[_i];
          _results.push(feed.fetch(1, 10, (function(_this) {
            return function(err, results) {
              return $scope.$apply();
            };
          })(this)));
        }
        return _results;
      };
      return $scope.refresh();
    }
  ]);

}).call(this);
