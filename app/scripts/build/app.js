(function() {
  var scottyApp;

  scottyApp = angular.module('scottyApp', ['ngRoute', 'homeControllers', 'versionsControllers']);

  scotty.versions.fetch();

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

  window.queue.on('queue:end', function(event) {
    return $.jGrowl("" + (event.getName()) + " completed");
  });

  scottyApp.config([
    '$routeProvider', function($routeProvider) {
      return $routeProvider.when('/', {
        templateUrl: 'templates/home/main.html',
        controller: 'Home.NewsController'
      }).when('/versions', {
        templateUrl: 'templates/versions/main.html',
        controller: 'Versions.ListController'
      });
    }
  ]);

}).call(this);
