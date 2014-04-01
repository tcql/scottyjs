(function() {
  window.VersionsListController = (function() {
    function VersionsListController(scope) {
      this.scope = scope;
      scotty.versions.versions.getAll((function(_this) {
        return function(err, versions) {
          _this.scope.available = versions;
          return _this.scope.$apply();
        };
      })(this));
      this.scope.versionsRefresh = this.versionsRefresh.bind(this);
    }

    VersionsListController.prototype.versionsRefresh = function() {
      return scotty.versions.fetch((function(_this) {
        return function(err, versions) {
          _this.scope.available = versions;
          return _this.scope.$apply();
        };
      })(this));
    };

    return VersionsListController;

  })();

}).call(this);
