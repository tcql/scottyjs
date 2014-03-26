Emitter = require('events').EventEmitter

class window.QueueManager extends Emitter
    constructor: ()->
        @queued_events = []
        @current = null


    getCurrent: ()->
        return @current


    getQueued: ()->
        return @queued_events


    queueEvent: (event)->
        @queued_events.push event
        @emit 'queue:changed', @queued_events.length
        event.on 'end', @_onEventEnd

        if not @current?
            @runNext()



    _onEventEnd: ()=>
        @emit('end', @current)
        @emit 'queue:changed', @queued_events.length
        @runNext()


    _onEventProgress: (progress)=>
        @emit('progress', progress, @current)


    runNext: ()->
        if @current?
            @current.removeListener('end', @_onEventEnd)
            @current.removeListener('progress', @_onEventProgress)

        @current = null
        if @queued_events.length > 0
            @emit 'queue:changed', @queued_events.length
            @current = @queued_events.shift()
            @current.start()
            @current.on 'progress', @_onEventProgress

        else
            @emit('queue:empty')

