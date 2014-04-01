
feed = angular.module 'scottyFeeds', []


class FeedProvider
    constructor: ()->
        @registry =
            "github": GithubFeed
            # register other feed types!?!?

    make: (type, options)->
        return new (@registry[type])(options)



feed.factory 'feedProvider', ($window)->
    return new FeedProvider
