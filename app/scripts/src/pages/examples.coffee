class window.ExamplesPage
    constructor: (sammy)->
        self = @

        sammy.get '#/examples', (context)->
            self.routeIndex(context, @)

        sammy.get '#/examples/install', (context)->
            self.routeInstall(context, @)

        sammy.get '#/examples/open', (context)->
            self.routeOpen(context, @)


    routeIndex: (context, route)=>
        route.installed = scotty.examples.installed()
        route.partial('templates/examples/main.hb')


    routeInstall: (context, route)=>
        route.message = "Downloading Examples..."
        route.submessage = "<em>This may take several minutes</em>"
        route.partial('templates/loading.hb')
        scotty.examples.download ()=>
            route.redirect("#/examples")


    routeOpen: (context, route)=>
        w = scotty.gui.spawn(
            "file://"+scotty.getExamplesDirectory()+"/examples/index.html",
            {
                "width":1300,
                "height":700,
                "toolbar":yes
            }
        )

        route.redirect("#/examples")
