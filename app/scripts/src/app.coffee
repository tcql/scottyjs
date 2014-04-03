scottyApp = angular.module 'scottyApp', [
    'ngRoute',
    'homeControllers',
    'versionsControllers',
    'examplesControllers',
    'projectsControllers',
]

scotty.versions.fetch()

scottyApp.config ['$routeProvider', ($routeProvider)->
    $routeProvider
        .when '/',
            templateUrl: 'templates/home/main.html'
            controller: 'Home.MainController'
        .when '/versions',
            templateUrl: 'templates/versions/main.html'
            controller: 'Versions.MainController'
        .when '/examples',
            templateUrl: 'templates/examples/main.html'
            controller: 'Examples.MainController'
        .when '/projects',
            templateUrl: 'templates/projects/main.html'
            controller: 'Projects.MainController'
        .when '/projects/edit/:id',
            templateUrl: 'templates/projects/addedit.html'
            controller: 'Projects.AddEditController'
        .when '/projects/add',
            templateUrl: 'templates/projects/addedit.html'
            controller: 'Projects.AddEditController'
        .when '/projects/delete/:id',
            templateUrl: 'templates/projects/delete.html'
            controller: 'Projects.DeleteController'
]
