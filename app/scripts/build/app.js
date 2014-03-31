(function() {
  var scottyApp;

  scottyApp = angular.module('scottyApp', ['ngRoute', 'homeControllers']);

  scottyApp.config([
    '$routeProvider', function($routeProvider) {
      return $routeProvider.when('/', {
        templateUrl: 'templates/home/main.html',
        controller: 'Home.NewsController'
      });
    }
  ]);

}).call(this);
