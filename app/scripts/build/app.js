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
