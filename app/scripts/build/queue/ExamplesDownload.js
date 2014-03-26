(function() {
  var Emitter,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  Emitter = require('events').EventEmitter;

  window.ExamplesDownload = (function(_super) {
    __extends(ExamplesDownload, _super);

    function ExamplesDownload() {
      return ExamplesDownload.__super__.constructor.apply(this, arguments);
    }

    return ExamplesDownload;

  })(Emitter);

}).call(this);
