
class window.VersionsPage
    constructor: (sammy)->
        self = @

        sammy.get '#/versions', (context)->
            self.routeIndex(context, @)

        sammy.get '#/versions/download/:version', (context)->
            self.routeDownloadVersion(context, @)

        sammy.get '#/versions/refresh', (context)->
            self.routeRefreshDownloads(context, @)


    ###
     * routeIndex(context, route) -> null
     *
     * Responds to the index route for the versions page
    ###
    routeIndex: (context, route)=>
        scotty.versions.versions.getAll (err, versions)=>
            route.available = versions
            route.partial('templates/versions/main.hb')


    ###
     * routeRefreshDownloads(context, route) -> null
     *
     * Handles requests to refresh list of available
     * phaser downloads
    ###
    routeRefreshDownloads: (context, route)=>
        route.message = "Refreshing..."
        route.partial('templates/loading.hb')

        # Fetch the version list and redirect
        scotty.versions.fetch (err, versions)=>
            context.redirect("#/versions")


    routeDownloadVersion: (context, route)=>
        version = route.params['version']

        # route.message = "Downloading..."
        # route.submessage = "<em>This may take several minutes</em>"

        # route.partial('templates/loading.hb')

        onDone = ()=>
            context.redirect "#/versions"

        onProgress = (state)->
            console.log state

        # Download a version and redirect
        scotty.versions.forceDownload version, onDone, onProgress
