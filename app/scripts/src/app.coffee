
$ ->
    window.nwgui = require('nw.gui')
    window.dev_tools = new window.scotty.gui.devTools(document, window)


    $("#layout").on 'click', '.open-external', (e)->
        e.preventDefault()
        nwgui.Shell.openExternal($(this).attr('href'))


    window.app = $.sammy "#main", ->
        @use('Handlebars', 'hb')
        @use('FormBuilder')
        @use('NestedParams')

        pages = []

        pages.push new HomePage(@)
        pages.push new VersionsPage(@)
        pages.push new ProjectsPage(@)
        pages.push new ExamplesPage(@)

        # pretty much just for debuggy stuff?
        window.pages = pages

    window.app.run('#/')

    nwgui.Window.get().show()

