(function() {
  $(function() {
    return $("#menu a").click(function() {
      if ($(this).hasClass("open-external")) {
        return;
      }
      $("#menu .active-link").removeClass("active-link");
      return $(this).addClass("active-link");
    });
  });

}).call(this);
