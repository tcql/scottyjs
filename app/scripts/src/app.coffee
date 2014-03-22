
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

        @swap = (content, callback)->
            context = @

            context.$element().fadeOut 'fast', ()->
                context.$element().html(content)
                context.$element().fadeIn 'fast', ()->
                    if callback
                        callback.apply()

        pages = []

        pages.push new HomePage(@)
        pages.push new VersionsPage(@)
        pages.push new ProjectsPage(@)
        pages.push new ExamplesPage(@)

        # pretty much just for debuggy stuff?
        window.pages = pages

    window.app.run('#/')

    nwgui.Window.get().show()

