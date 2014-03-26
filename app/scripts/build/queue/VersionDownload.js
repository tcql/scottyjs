(function() {
  var Emitter,
    __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; },
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  Emitter = require('events').EventEmitter;

  window.VersionDownload = (function(_super) {
    __extends(VersionDownload, _super);

    function VersionDownload(version) {
      this.version = version;
      this._onProgress = __bind(this._onProgress, this);
      this._onDone = __bind(this._onDone, this);
      scotty.versions.versions.setInProgress(this.version);
    }

    VersionDownload.prototype.start = function() {
      return scotty.versions.forceDownload(this.version, this._onDone, this._onProgress);
    };

    VersionDownload.prototype._onDone = function(e) {
      return this.emit('end', e);
    };

    VersionDownload.prototype._onProgress = function(e) {
      return this.emit('progress', e);
    };

    return VersionDownload;

  })(Emitter);

}).call(this);
