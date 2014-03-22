(function() {
  $(function() {
    return $("#menu a").click(function() {
      $("#menu .active-link").removeClass("active-link");
      return $(this).addClass("active-link");
    });
  });

}).call(this);
