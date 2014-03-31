
feed = angular.module 'scottyFeeds', []


class FeedProvider
    constructor: ()->
        @registry =
            "github": GithubFeed

    make: (type, options)->
        return new (@registry[type])(options)



feed.factory 'feedProvider', ($window)->
    return new FeedProvider
