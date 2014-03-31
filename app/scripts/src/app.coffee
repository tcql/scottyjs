scottyApp = angular.module 'scottyApp', [
    'ngRoute',
    'homeControllers'
]


scottyApp.config ['$routeProvider', ($routeProvider)->
    $routeProvider
        .when '/',
            templateUrl: 'templates/home/main.html'
            controller: 'Home.NewsController'
]
