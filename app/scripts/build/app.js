(function() {
  $(function() {
    window.nwgui = require('nw.gui');
    window.dev_tools = new window.scotty.gui.devTools(document, window);
    window.queue = new QueueManager;
    window.queue.on('progress', function(progress) {
      if (progress.percent) {
        return $(".queue-progress").css({
          width: "" + progress.percent + "%"
        });
      }
    });
    window.queue.on('queue:empty', function() {
      return $(".queue-progress").css({
        width: "0%"
      });
    });
    window.queue.on('queue:changed', function(number) {
      return $(".queue-text").text("" + number + " items");
    });
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
