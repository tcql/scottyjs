Emitter = require('events').EventEmitter

class window.DownloadEvent extends Emitter

    constructor: (@version)->
        scotty.versions.versions.setInProgress(@version)

    start: ()->
        scotty.versions.forceDownload @version, @_onDone, @_onProgress


    _onDone: (e)=>
        @emit('end', e)

    _onProgress: (e)=>
        @emit('progress', e)
