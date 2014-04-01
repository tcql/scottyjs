
controllers = angular.module 'homeControllers', ['scottyFeeds']

controllers.controller 'Home.NewsController', ['$scope', 'feedProvider', ($scope, feedProvider)->
    $scope.feeds = [
        feedProvider.make("github", {name:"Phaser Github Activity" , user:"photonstorm", repo: "phaser"})
        feedProvider.make("github", {name:"scotty.js Github Activity", user:"tchannel", repo: "scottyjs"})
    ]

    $scope.refresh: ()->
        for feed in $scope.feeds
            feed.fetch 1, 10, (err, results)=>
                $scope.$apply()

    $scope.refresh()
]
