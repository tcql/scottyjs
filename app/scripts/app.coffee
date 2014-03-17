window.scotty_lib = require("scotty-lib")
window.scotty = scotty.initialize()

$ ->
    window.app = $.sammy "#main", ->
        @use('Handlebars', 'hb')
        @use('FormBuilder')
        @use('NestedParams')

        Handlebars.registerHelper 'call', (context, options)->
            console.log context

        @get '#/', (context)->
            @partial('templates/home.hb')

        window.vPage = new VersionsPage(@)
        window.pPage = new ProjectsPage(@)


    window.app.run('#/')

