window.scotty_lib = require("scotty-lib")
window.scotty = scotty.initialize()

$ ->
    app = $.sammy "#main", ->
        @use('Handlebars', 'hb')

        @get '#/', (context)->
            @partial('templates/home.hb')

        window.vPage = new VersionsPage(@)
        window.pPage = new ProjectsPage(@)


    app.run('#/')

