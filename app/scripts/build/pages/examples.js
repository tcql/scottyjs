(function() {
  var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  window.ExamplesPage = (function() {
    function ExamplesPage(sammy) {
      this.routeOpen = __bind(this.routeOpen, this);
      this.routeInstall = __bind(this.routeInstall, this);
      this.routeIndex = __bind(this.routeIndex, this);
      var self;
      self = this;
      sammy.get('#/examples', function(context) {
        return self.routeIndex(context, this);
      });
      sammy.get('#/examples/install', function(context) {
        return self.routeInstall(context, this);
      });
      sammy.get('#/examples/open', function(context) {
        return self.routeOpen(context, this);
      });
    }

    ExamplesPage.prototype.routeIndex = function(context, route) {
      route.queued = window.examples_queued;
      route.installed = scotty.examples.installed();
      return route.partial('templates/examples/main.hb');
    };

    ExamplesPage.prototype.routeInstall = function(context, route) {
      var item;
      item = new ExamplesDownload;
      window.examples_queued = true;
      window.queue.queueEvent(item);
      item.on('end', (function(_this) {
        return function() {
          return window.examples_queued = false;
        };
      })(this));
      return route.redirect("#/examples");
    };

    ExamplesPage.prototype.routeOpen = function(context, route) {
      var w;
      w = scotty.gui.spawn("file://" + scotty.getExamplesDirectory() + "/examples/index.html", {
        "width": 1300,
        "height": 700,
        "toolbar": true
      }, false);
      return route.redirect("#/examples");
    };

    return ExamplesPage;

  })();

}).call(this);
