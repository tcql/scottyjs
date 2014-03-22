class window.HomePage

    constructor: (sammy)->
        self = @

        @feeds = [
            new GithubFeed({
                feed_name: "Phaser Github Activity",
                feed_class: "phaser-github"
            }, "photonstorm", "phaser")

            new GithubFeed({
                feed_name: "scotty.js Github Activity"
                feed_class: "scotty-github"
            }, "tchannel", "scottyjs")
        ]

        sammy.get '#/', (context)->
            self.routeIndex(context, @)


    routeIndex: (context, route)=>

        route.partial('templates/home.hb')
        route.renderEach("templates/home/feedrow.hb", @feeds).appendTo(".feeds")

        @renderAllFeeds(@feeds, route)


    renderAllFeeds: (feeds, route)->
        for feed in feeds
            @renderFeed(feed, route)


    renderFeed: (feed, route)->
        feed.fetch 1, 20, (err, results)->
            if err
                msg = feed.parseError(err)
                $(".#{feed.options.feed_class} .loading").html("There was an error retrieving the feed. #{msg}")
            else if results.length is 0
                $("#{feed.options.feed_class} .loading").html("No activity.")
            else
                $(".#{feed.options.feed_class} .loading").hide()
                route.renderEach("#{feed.template}", results).appendTo(".#{feed.options.feed_class} .feed-table")
                    .then ()->
                        $(".#{feed.options.feed_class} .feed-table .fade-in").addClass 'fade-in-visible'
