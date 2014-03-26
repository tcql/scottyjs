(function() {
  var Emitter,
    __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; },
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  Emitter = require('events').EventEmitter;

  window.QueueManager = (function(_super) {
    __extends(QueueManager, _super);

    function QueueManager() {
      this._onEventProgress = __bind(this._onEventProgress, this);
      this._onEventEnd = __bind(this._onEventEnd, this);
      this.queued_events = [];
      this.current = null;
    }

    QueueManager.prototype.getCurrent = function() {
      return this.current;
    };

    QueueManager.prototype.getQueued = function() {
      return this.queued_events;
    };

    QueueManager.prototype.getCount = function() {
      var count;
      count = 0;
      if (this.current != null) {
        count++;
      }
      count += this.queued_events.length;
      return count;
    };

    QueueManager.prototype.queueEvent = function(event) {
      this.queued_events.push(event);
      this.emit('queue:changed', this.getCount());
      event.on('end', this._onEventEnd);
      if (this.current == null) {
        return this.runNext();
      }
    };

    QueueManager.prototype._onEventEnd = function() {
      this.emit('end', this.current);
      this.emit('queue:changed', this.getCount());
      return this.runNext();
    };

    QueueManager.prototype._onEventProgress = function(progress) {
      return this.emit('progress', progress, this.current);
    };

    QueueManager.prototype.runNext = function() {
      if (this.current != null) {
        this.current.removeListener('end', this._onEventEnd);
        this.current.removeListener('progress', this._onEventProgress);
      }
      this.current = null;
      if (this.queued_events.length > 0) {
        this.emit('queue:changed', this.getCount());
        this.current = this.queued_events.shift();
        this.current.start();
        return this.current.on('progress', this._onEventProgress);
      } else {
        this.emit('queue:empty');
        return this.emit('queue:changed', this.getCount());
      }
    };

    return QueueManager;

  })(Emitter);

}).call(this);
