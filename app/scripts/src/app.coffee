scottyApp = angular.module 'scottyApp', [
    'ngRoute',
    'homeControllers',
    'versionsControllers',
    'examplesControllers',
    'projectsControllers',
]

scotty.versions.fetch()
window.nwgui = require('nw.gui')
window.dev_tools = new window.scotty.gui.devTools(document, window)

## TODO! made add a service for the queuemanager or .. something or other. It's a bit messy here.
window.queue = new QueueManager

window.queue.on 'queue:progress', (progress)->
    if progress.percent
        $(".queue-progress").css width: "#{progress.percent}%"

window.queue.on 'queue:empty', ()->
    $(".queue-progress").css width: "0%"
    $(".queue-text").text "0 items"

window.queue.on 'queue:change', (number)->
    $(".queue-text").text "#{number} items"

window.queue.on 'queue:add', (event)->
    $.jGrowl("Added #{event.getName()} to download queue")

window.queue.on 'queue:end', (event)->
    $.jGrowl("#{event.getName()} completed")


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
]
