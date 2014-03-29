
$ ->
    window.nwgui = require('nw.gui')
    window.dev_tools = new window.scotty.gui.devTools(document, window)
    window.queue = new QueueManager

    window.queue.on 'queue:progress', (progress)->
        console.log progress
        if progress.percent
            $(".queue-progress").css width: "#{progress.percent}%"

    window.queue.on 'queue:empty', ()->
        $(".queue-progress").css width: "0%"
        $(".queue-text").text "0 items"

    window.queue.on 'queue:change', (number)->
        $(".queue-text").text "#{number} items"

    window.queue.on 'queue:add', (event)->
        $.jGrowl("Added #{event.getName()} to download queue")

    window.queue.on 'queue:end', (event)->
        $.jGrowl("#{event.getName()} completed")


    # Pre-fetch versions when the app runs
    scotty.versions.fetch()

    $("#layout").on 'click', '.open-external', (e)->
        e.preventDefault()
        nwgui.Shell.openExternal($(this).attr('href'))


    window.app = $.sammy "#main", ->
        @use('Handlebars', 'hb')
        @use('FormBuilder')
        @use('NestedParams')

        ## Fade implementation.
        # @swap = (content, callback)->
        #     context = @

        #     context.$element().fadeOut 'fast', ()->
        #         context.$element().html(content)
        #         context.$element().fadeIn 'fast', ()->
        #             if callback
        #                 callback.apply()

        pages = []

        pages.push new HomePage(@)
        pages.push new VersionsPage(@)
        pages.push new ProjectsPage(@)
        pages.push new ExamplesPage(@)

        # pretty much just for debuggy stuff?
        window.pages = pages

    window.app.run('#/')

    nwgui.Window.get().show()

