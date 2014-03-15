class window.VersionsPage
    constructor: (sammy)->
        self = @
        sammy.get '#/versions', (context)->
            self.routeIndex(context, @)

        sammy.get '#/versions/download/:version', (context)->
            self.routeDownloadVersion(context, @)


    routeIndex: (context, route)=>
        route.installed = ['1.1.6']

        route.available = [
            {name:'1.1.6', installed: true},
            {name:'1.1.5', installed: route.params['installed']},
            {name:'1.1.4', installed: route.params['installed']}
        ]

        route.partial('templates/versions/main.hb')


    routeDownloadVersion: (context, route)=>
        console.log(route.params['version'])
