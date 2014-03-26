(function() {
  $(function() {
    window.nwgui = require('nw.gui');
    window.dev_tools = new window.scotty.gui.devTools(document, window);
    window.queue = new QueueManager;
    window.queue.on('queue:progress', function(progress) {
      progress;
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
    window.queue.on('queue:change', function(number) {
      return $(".queue-text").text("" + number + " items");
    });
    window.queue.on('queue:add', function(event) {
      return $.jGrowl("Added " + (event.getName()) + " to download queue");
    });
    window.queue.on('queue:end', function(event) {
      return $.jGrowl("" + (event.getName()) + " completed");
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
