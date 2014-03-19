window.scotty_lib = require("scotty-lib")
window.scotty = scotty.initialize()

connect = require('connect');

console.log window.location
# connect.createServer(
#     connect.static(scotty.getExamplesDirectory())
# ).listen(8081);


$ ->

    window.app = $.sammy "#main", ->
        @use('Handlebars', 'hb')
        @use('FormBuilder')
        @use('NestedParams')

        Handlebars.registerHelper 'call', (context, options)->
            console.log context

        @get '#/', (context)->
            @partial('templates/home.hb')


        @get '#/examples', (context)->
            window.open(
                "file://"+scotty.getExamplesDirectory()+"/examples/index.html",
                "_blank",
                "width=1300,height=700"
            )
            @redirect("#/")

        window.vPage = new VersionsPage(@)
        window.pPage = new ProjectsPage(@)




    window.app.run('#/')

