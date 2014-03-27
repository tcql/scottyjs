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
        route.queued = window.examples_queued
        route.installed = scotty.examples.installed()
        route.partial('templates/examples/main.hb')


    routeInstall: (context, route)=>
        # route.message = "Downloading Examples..."
        # route.submessage = "<em>This may take several minutes</em>"
        # route.partial('templates/loading.hb')

        item = new ExamplesDownload

        # Hacky way of tracking "in progress" for
        # examples. Some day I'll setup a general options / config
        # file that'll hold that. or something
        window.examples_queued = true
        window.queue.queueEvent item

        item.on 'end', ()=>
            window.examples_queued = false
           route.redirect("#/examples")

        #scotty.examples.download ()=>



    routeOpen: (context, route)=>
        w = scotty.gui.spawn(
            "file://"+scotty.getExamplesDirectory()+"/examples/index.html",
            {
                "width":1300,
                "height":700,
                "toolbar":yes
            },
            false
        )

        route.redirect("#/examples")
