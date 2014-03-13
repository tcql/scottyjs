$(function() {

    var devToolsToggle = function() {
        var nwindow = nwgui.Window.get()

        if (nwindow.isDevToolsOpen()) {
            nwindow.closeDevTools();
        } else {
            nwindow.showDevTools();
        }
    }

    $(document).keydown(function (e) {
        if ((e.ctrlKey) && (e.shiftKey) && (e.which == 73)) {
            devToolsToggle()
        }
    });

});
