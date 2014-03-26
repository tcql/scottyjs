(function() {
  var Emitter,
    __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; },
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  Emitter = require('events').EventEmitter;

  window.ExamplesDownload = (function(_super) {
    __extends(ExamplesDownload, _super);

    function ExamplesDownload() {
      this._onProgress = __bind(this._onProgress, this);
      this._onDone = __bind(this._onDone, this);
    }

    ExamplesDownload.prototype.start = function() {
      return scotty.examples.download(this._onDone, this._onProgress);
    };

    ExamplesDownload.prototype.getName = function() {
      return "Phaser Examples";
    };

    ExamplesDownload.prototype._onDone = function(e) {
      return this.emit('end', e);
    };

    ExamplesDownload.prototype._onProgress = function(e) {
      return this.emit('progress', e);
    };

    return ExamplesDownload;

  })(Emitter);

}).call(this);
