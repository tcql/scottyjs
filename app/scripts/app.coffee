$ ->
    app = $.sammy "#main", ->
        @use('Handlebars', 'hb')

        @get '#/', (context)->
            @partial('templates/home.hb')

        new VersionsPage(@)
        new ProjectsPage(@)


    app.run('#/')

