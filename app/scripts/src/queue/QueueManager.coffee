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
        @emit 'queue:change', @getCount()
        @emit 'queue:add', event
        event.on 'end', @_onEventEnd

        if not @current?
            @runNext()



    _onEventEnd: ()=>
        @emit('queue:end', @current)
        @emit 'queue:change', @getCount()
        @runNext()


    _onEventProgress: (progress)=>
        @emit('queue:progress', progress, @current)


    runNext: ()->
        if @current?
            @current.removeListener('end', @_onEventEnd)
            @current.removeListener('progress', @_onEventProgress)

        @current = null
        if @queued_events.length > 0
            @emit 'queue:change', @getCount()
            @current = @queued_events.shift()
            @current.start()
            @emit 'queue:start', @current
            @current.on 'progress', @_onEventProgress

        else
            @emit('queue:empty')
            @emit 'queue:changed', @getCount()

