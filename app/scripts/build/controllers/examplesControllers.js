(function() {
  var controllers;

  controllers = angular.module('examplesControllers', []);

  controllers.controller('Examples.MainController', [
    '$scope', function($scope) {
      $scope.queued = false;
      $scope.installed = scotty.examples.installed();
      $scope.download = function() {
        var item;
        item = new ExamplesDownload;
        $scope.queued = true;
        $scope.installed = false;
        window.queue.queueEvent(item);
        return item.on('end', (function(_this) {
          return function() {
            $scope.queued = false;
            return $scope.installed = true;
          };
        })(this));
      };
      return $scope.view = function() {
        var w;
        return w = scotty.gui.spawn("file://" + scotty.getExamplesDirectory() + "/examples/index.html", {
          "width": 1300,
          "height": 700,
          "toolbar": true
        }, false);
      };
    }
  ]);

}).call(this);
