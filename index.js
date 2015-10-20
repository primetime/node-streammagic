var Readable, Stream,
  extend = function(child, parent) { for (var key in parent) { if (hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
  hasProp = {}.hasOwnProperty;

Readable = require('stream').Readable;

Stream = (function(superClass) {
  extend(Stream, superClass);

  function Stream(data) {
    var i, j, o;
    if (typeof data === 'object' && !Buffer.isBuffer(data)) {
      if (Array.isArray(data)) {
        this.data = data;
      } else {
        this.data = [];
        for (i in data) {
          j = data[i];
          o = {};
          o[i] = j;
          this.data.push(o);
        }
      }
    } else {
      this.data = data;
    }
    Readable.call(this, {
      objectMode: true
    });
  }

  Stream.prototype._read = function() {
    if (Array.isArray(this.data)) {
      this.push(this.data.splice(0, 1)[0]);
      if (this.data.length === 0) {
        return this.push(null);
      }
    } else if (Buffer.isBuffer(this.data)) {
      this.push(new Buffer(this.data));
      return this.push(null);
    } else {
      this.push(this.data);
      return this.push(null);
    }
  };

  return Stream;

})(Readable);

module.exports = function() {
  var i, k, l, len, len1, ref, ref1, results;
  ref = [Boolean, Number, String];
  for (k = 0, len = ref.length; k < len; k++) {
    i = ref[k];
    Object.defineProperty(i.prototype, 'toStream', {
      value: function() {
        return new Stream(this.valueOf());
      },
      writable: false,
      configurable: false,
      enumerable: false
    });
  }
  ref1 = [Array, Buffer, Object];
  results = [];
  for (l = 0, len1 = ref1.length; l < len1; l++) {
    i = ref1[l];
    results.push(Object.defineProperty(i.prototype, 'toStream', {
      value: function() {
        return new Stream(this);
      },
      writable: false,
      configurable: false,
      enumerable: false
    }));
  }
  return results;
};
