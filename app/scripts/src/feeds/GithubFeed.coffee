# Simple reader for github commits. In the future I might expand this to
# read commits, tags, and issues / PRs and sort them by time so you can
# get a complete list of what's happening.
class window.GithubFeed
    constructor: (@options, @user, @repo)->
        @template = 'templates/home/githubfeed.hb'


    fetch: (page = 1, num_per_page = 10, callback = ->) ->
        scotty.api.repos.getCommits
            user: @user
            repo: @repo
            page: page
            per_page: num_per_page,
            (err, results)=>
                return callback(err, null) if err

                activity = []
                for commit in results
                    activity.push @makeRecord(commit)

                callback(null, activity)

    parseError: (error)->
        try
            return $.parseJSON(error.message).message
        catch e
            return error


    makeRecord: (result)->
        return {
            icon: result.author.avatar_url
            icon_link: result.author.html_url
            author: result.author.login
            #todo: format date
            date: moment(result.commit.committer.date).format('YYYY-MM-DD HH:MM')
            message: result.commit.message
            link: result.html_url
        }
