window.scotty_lib = require("scotty-lib")
window.scotty = scotty.initialize()

connect = require('connect');

console.log window.location
# connect.createServer(
#     connect.static(scotty.getExamplesDirectory())
# ).listen(8081);


$ ->
    console.log scotty
    window.dev_tools = new window.scotty.gui.devTools(document, window)

    window.app = $.sammy "#main", ->
        @use('Handlebars', 'hb')
        @use('FormBuilder')
        @use('NestedParams')

        Handlebars.registerHelper 'call', (context, options)->
            console.log context

        @get '#/', (context)->
            @partial('templates/home.hb')


        @get '#/examples', (context)->
            w = scotty.gui.spawn(
                "file://"+scotty.getExamplesDirectory()+"/examples/index.html",
                {
                    "width":1300,
                    "height":700,
                    "toolbar":yes
                }
            )

            @redirect("#/")


        window.vPage = new VersionsPage(@)
        window.pPage = new ProjectsPage(@)




    window.app.run('#/')

