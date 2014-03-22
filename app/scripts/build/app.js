(function() {
  $(function() {
    window.nwgui = require('nw.gui');
    window.dev_tools = new window.scotty.gui.devTools(document, window);
    $("#layout").on('click', '.open-external', function(e) {
      e.preventDefault();
      return nwgui.Shell.openExternal($(this).attr('href'));
    });
    window.app = $.sammy("#main", function() {
      var pages;
      this.use('Handlebars', 'hb');
      this.use('FormBuilder');
      this.use('NestedParams');
      this.swap = function(content, callback) {
        var context;
        context = this;
        return context.$element().fadeOut('fast', function() {
          context.$element().html(content);
          return context.$element().fadeIn('fast', function() {
            if (callback) {
              return callback.apply();
            }
          });
        });
      };
      pages = [];
      pages.push(new HomePage(this));
      pages.push(new VersionsPage(this));
      pages.push(new ProjectsPage(this));
      pages.push(new ExamplesPage(this));
      return window.pages = pages;
    });
    window.app.run('#/');
    return nwgui.Window.get().show();
  });

}).call(this);
