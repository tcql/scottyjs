
class window.GithubFeed
    constructor: (options = {})->
        @errorMessage = null
        @latestResults = []
        @fetching = false
        @setUp(options)


    setUp: (options)->
        @name = options.name
        @user = options.user
        @repo = options.repo


    fetch: (page = 1, num_per_page = 10, callback = ->) ->
        @fetching = true
        scotty.api.repos.getCommits
            user: @user
            repo: @repo
            page: page
            per_page: num_per_page,
            (err, results)=>
                @fetching = false
                @errorMessage = null
                @latestResults.splice(0)

                if err
                    @errorMessage = @parseError(err)
                    return callback(err, null)

                for commit in results
                    @latestResults.push @makeRecord(commit)

                callback(null, @latestResults)


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
            date: moment(result.commit.committer.date).format('YYYY-MM-DD HH:MM')
            message: result.commit.message
            link: result.html_url
        }
