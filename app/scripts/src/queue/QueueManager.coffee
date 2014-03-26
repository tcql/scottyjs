Emitter = require('events').EventEmitter

class window.QueueManager extends Emitter
    constructor: ()->
        @queued_events = []
        @current = null


    getCurrent: ()->
        return @current


    getQueued: ()->
        return @queued_events


    getCount: ()->
        count = 0
        count++ if @current?
        count += @queued_events.length

        return count


    queueEvent: (event)->
        @queued_events.push event
        @emit 'queue:changed', @getCount()
        event.on 'end', @_onEventEnd

        if not @current?
            @runNext()



    _onEventEnd: ()=>
        @emit('end', @current)
        @emit 'queue:changed', @getCount()
        @runNext()


    _onEventProgress: (progress)=>
        @emit('progress', progress, @current)


    runNext: ()->
        if @current?
            @current.removeListener('end', @_onEventEnd)
            @current.removeListener('progress', @_onEventProgress)

        @current = null
        if @queued_events.length > 0
            @emit 'queue:changed', @getCount()
            @current = @queued_events.shift()
            @current.start()
            @current.on 'progress', @_onEventProgress

        else
            @emit('queue:empty')
            @emit 'queue:changed', @getCount()

