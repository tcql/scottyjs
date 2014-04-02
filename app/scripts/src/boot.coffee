$ ->
    window.nwgui = require('nw.gui')
    window.dev_tools = new window.scotty.gui.devTools(document, window)

    $("#layout").on 'click', '.open-external', (e)->
        e.preventDefault()
        nwgui.Shell.openExternal($(this).attr('href'))


    ## TODO! made add a service for the queuemanager or .. something or other. It's a bit messy here.
    window.queue = new QueueManager

    window.queue.on 'queue:progress', (progress)->
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

