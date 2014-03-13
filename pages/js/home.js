window.nwgui = require('nw.gui');

$(function () {
    $(".open-external").click( function (e) {
        e.preventDefault()
        nwgui.Shell.openExternal($(this).attr('href'))
    });
});
