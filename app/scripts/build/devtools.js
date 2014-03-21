(function() {
  var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  window.scotty.gui.devTools = (function() {
    function devTools(document, window) {
      this.document = document;
      this.window = window;
      this.bindListener = __bind(this.bindListener, this);
      this.toggle = __bind(this.toggle, this);
      this.bindListener();
    }

    devTools.prototype.toggle = function() {
      var nwindow;
      nwindow = this.window.nwgui.Window.get();
      if (nwindow.isDevToolsOpen()) {
        return nwindow.closeDevTools();
      } else {
        return nwindow.showDevTools();
      }
    };

    devTools.prototype.bindListener = function() {
      return $(this.document).keydown((function(_this) {
        return function(e) {
          if ((e.ctrlKey && e.shiftKey && (e.which === 73)) || (e.which === 117)) {
            _this.toggle();
          }
          if ((e.ctrlKey && (e.which === 82)) || (e.which === 116)) {
            return _this.window.location.reload();
          }
        };
      })(this));
    };

    return devTools;

  })();

  window.scotty.gui.spawn = function(url, options, attach_devtools) {
    var w;
    if (attach_devtools == null) {
      attach_devtools = true;
    }
    w = nwgui.Window.open(url, options);
    if (attach_devtools) {
      return w.on('loaded', function() {
        w.window.nwgui = w.window.nwDispatcher.requireNwGui();
        return w.window.dev_tools = new scotty.gui.devTools(w.window.document, w.window);
      });
    }
  };

}).call(this);
