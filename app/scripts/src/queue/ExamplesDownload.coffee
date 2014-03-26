Emitter = require('events').EventEmitter

class window.ExamplesDownload extends Emitter

    constructor: ()->

    start: ()->
        scotty.examples.download @_onDone, @_onProgress


    _onDone: (e)=>
        @emit('end', e)

    _onProgress: (e)=>
        @emit('progress', e)
