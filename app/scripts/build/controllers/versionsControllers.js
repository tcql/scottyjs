(function() {
  var controllers;

  controllers = angular.module('versionsControllers', []);

  controllers.controller('Versions.MainController', [
    '$scope', function($scope) {
      $scope.loadVersions = function() {
        $scope.refreshing = false;
        return scotty.versions.versions.getAll((function(_this) {
          return function(err, versions) {
            $scope.available = versions;
            return $scope.$apply();
          };
        })(this));
      };
      $scope.loadVersions();
      $scope.refresh = function() {
        $scope.refreshing = true;
        return scotty.versions.fetch((function(_this) {
          return function(versions) {
            return $scope.loadVersions();
          };
        })(this));
      };
      return $scope.download = function(version) {
        var download;
        version.in_progress = true;
        download = new VersionDownload(version.name);
        window.queue.queueEvent(download);
        return download.on('end', function(item) {
          version.in_progress = false;
          version.installed = true;
          return $scope.$apply();
        });
      };
    }
  ]);

}).call(this);
