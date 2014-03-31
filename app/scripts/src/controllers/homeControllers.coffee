
controllers = angular.module 'homeControllers', ['scottyFeeds']


class NewsController
    constructor: ($scope, feedProvider)->
        @scope = $scope

        $scope.feeds = [
            feedProvider.make("github", {name:"Phaser Github Activity" , user:"photonstorm", repo: "phaser"})
            feedProvider.make("github", {name:"scotty.js Github Activity", user:"tchannel", repo: "scottyjs"})
        ]

        @refresh()


    refresh: ()->
        for feed in @scope.feeds
            feed.fetch 1, 10, (err, results)=>
                @scope.$apply()


controllers.controller 'Home.NewsController', ['$scope', 'feedProvider', NewsController]
