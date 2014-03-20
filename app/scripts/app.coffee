
$ ->
    window.dev_tools = new window.scotty.gui.devTools(document, window)

    window.app = $.sammy "#main", ->
        @use('Handlebars', 'hb')
        @use('FormBuilder')
        @use('NestedParams')


        @get '#/', (context)->
            @partial('templates/home.hb')


        pages = []

        pages.push(new VersionsPage(@))
        pages.push(new ProjectsPage(@))
        pages.push(new ExamplesPage(@))

        # pretty much just for debuggy stuff?
        window.pages = pages

    window.app.run('#/')

