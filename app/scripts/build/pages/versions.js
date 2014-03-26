(function() {
  var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  window.VersionsPage = (function() {
    function VersionsPage(sammy) {
      this.routeDownloadVersion = __bind(this.routeDownloadVersion, this);
      this.routeRefreshDownloads = __bind(this.routeRefreshDownloads, this);
      this.routeIndex = __bind(this.routeIndex, this);
      var self;
      self = this;
      sammy.get('#/versions', function(context) {
        return self.routeIndex(context, this);
      });
      sammy.get('#/versions/download/:version', function(context) {
        return self.routeDownloadVersion(context, this);
      });
      sammy.get('#/versions/refresh', function(context) {
        return self.routeRefreshDownloads(context, this);
      });
    }


    /*
     * routeIndex(context, route) -> null
     *
     * Responds to the index route for the versions page
     */

    VersionsPage.prototype.routeIndex = function(context, route) {
      return scotty.versions.versions.getAll((function(_this) {
        return function(err, versions) {
          route.available = versions;
          return route.partial('templates/versions/main.hb');
        };
      })(this));
    };


    /*
     * routeRefreshDownloads(context, route) -> null
     *
     * Handles requests to refresh list of available
     * phaser downloads
     */

    VersionsPage.prototype.routeRefreshDownloads = function(context, route) {
      route.message = "Refreshing...";
      route.partial('templates/loading.hb');
      return scotty.versions.fetch((function(_this) {
        return function(err, versions) {
          return context.redirect("#/versions");
        };
      })(this));
    };

    VersionsPage.prototype.routeDownloadVersion = function(context, route) {
      var download, version;
      version = route.params['version'];
      download = new VersionDownload(version);
      window.queue.queueEvent(download);
      download.on('end', function(item) {
        if ("#\/versions".match(app.last_route.path) != null) {
          return context.redirect("#/versions");
        }
      });
      return setTimeout(function() {
        return context.redirect("#/versions");
      }, 100);
    };

    return VersionsPage;

  })();

}).call(this);
