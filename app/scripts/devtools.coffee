
class window.scotty.gui.devTools
    constructor: (@document, @window)->
        @bindListener()

    toggle: ()=>
        nwindow = @window.nwgui.Window.get()

        if nwindow.isDevToolsOpen()
            nwindow.closeDevTools()
        else
            nwindow.showDevTools()

    bindListener: ()=>
        $(@document).keydown (e)=>
            if ((e.ctrlKey) and (e.shiftKey) and (e.which is 73)) or (e.which is 117)
                @toggle()

            if ((e.ctrlKey) and (e.which is 82)) || (e.which is 116)
                @window.location.reload()


window.scotty.gui.spawn = (url, options, attach_devtools = true)->
    w = nwgui.Window.open(url, options)

    if attach_devtools
        w.on 'loaded', ()->
            w.window.nwgui = w.window.nwDispatcher.requireNwGui()
            w.window.dev_tools = new scotty.gui.devTools(w.window.document, w.window)

