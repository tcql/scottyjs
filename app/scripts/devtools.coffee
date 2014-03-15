$ ->

    devToolsToggle = ()->
        nwindow = nwgui.Window.get()

        if nwindow.isDevToolsOpen()
            nwindow.closeDevTools()
        else
            nwindow.showDevTools()


    $(document).keydown (e)->
        if ((e.ctrlKey) and (e.shiftKey) and (e.which == 73)) or (e.which == 117)
            devToolsToggle()


        if ((e.ctrlKey) && (e.which == 82)) or (e.which == 116)
            location.reload()

