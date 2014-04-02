(function() {
  $(function() {
    window.nwgui = require('nw.gui');
    window.dev_tools = new window.scotty.gui.devTools(document, window);
    $("#layout").on('click', '.open-external', function(e) {
      e.preventDefault();
      return nwgui.Shell.openExternal($(this).attr('href'));
    });
    window.queue = new QueueManager;
    window.queue.on('queue:progress', function(progress) {
      if (progress.percent) {
        return $(".queue-progress").css({
          width: "" + progress.percent + "%"
        });
      }
    });
    window.queue.on('queue:empty', function() {
      $(".queue-progress").css({
        width: "0%"
      });
      return $(".queue-text").text("0 items");
    });
    window.queue.on('queue:change', function(number) {
      return $(".queue-text").text("" + number + " items");
    });
    window.queue.on('queue:add', function(event) {
      return $.jGrowl("Added " + (event.getName()) + " to download queue");
    });
    return window.queue.on('queue:end', function(event) {
      return $.jGrowl("" + (event.getName()) + " completed");
    });
  });

}).call(this);
