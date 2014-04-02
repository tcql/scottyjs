(function() {
  var scottyApp;

  scottyApp = angular.module('scottyApp', ['ngRoute', 'homeControllers', 'versionsControllers', 'examplesControllers', 'projectsControllers']);

  scotty.versions.fetch();

  window.nwgui = require('nw.gui');

  window.dev_tools = new window.scotty.gui.devTools(document, window);

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
        controller: 'Home.MainController'
      }).when('/versions', {
        templateUrl: 'templates/versions/main.html',
        controller: 'Versions.MainController'
      }).when('/examples', {
        templateUrl: 'templates/examples/main.html',
        controller: 'Examples.MainController'
      }).when('/projects', {
        templateUrl: 'templates/projects/main.html',
        controller: 'Projects.MainController'
      }).when('/projects/edit/:id', {
        templateUrl: 'templates/projects/addedit.html',
        controller: 'Projects.AddEditController'
      }).when('/projects/add', {
        templateUrl: 'templates/projects/addedit.html',
        controller: 'Projects.AddEditController'
      });
    }
  ]);

}).call(this);
