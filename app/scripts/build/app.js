(function() {
  $(function() {
    window.nwgui = require('nw.gui');
    window.dev_tools = new window.scotty.gui.devTools(document, window);
    $(".open-external").click(function(e) {
      e.preventDefault();
      return nwgui.Shell.openExternal($(this).attr('href'));
    });
    window.app = $.sammy("#main", function() {
      var pages;
      this.use('Handlebars', 'hb');
      this.use('FormBuilder');
      this.use('NestedParams');
      this.get('#/', function(context) {
        return this.partial('templates/home.hb');
      });
      pages = [];
      pages.push(new VersionsPage(this));
      pages.push(new ProjectsPage(this));
      pages.push(new ExamplesPage(this));
      return window.pages = pages;
    });
    return window.app.run('#/');
  });

}).call(this);
