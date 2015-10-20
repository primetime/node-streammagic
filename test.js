var chai, lipsum, mocha, test_stream_data;

require('./')();

lipsum = require('simple-lipsum');

mocha = require('mocha');

chai = require('chai');

chai.should();

test_stream_data = function(data, callback) {
  var result;
  result = [];
  return data.toStream().on('data', function(data) {
    return result.push(data);
  }).on('end', function() {
    return callback(null, result);
  }).on('error', function(err) {
    return callback(err);
  });
};

describe('String', function() {
  describe('"hello world"', function() {
    var data;
    data = [];
    before(function(done) {
      return test_stream_data('hello world', function(err, result) {
        if (err) {
          return console.error(err);
        }
        data = result;
        return done();
      });
    });
    it('should have one data event', function() {
      return data.length.should.equal(1);
    });
    it('should be a string', function() {
      return data[0].should.be.a('string');
    });
    return it('should contain "hello world"', function() {
      return data[0].should.equal('hello world');
    });
  });
  return describe('a paragraph of lorem ipsum', function() {
    var data;
    data = [];
    before(function(done) {
      return test_stream_data(lipsum.getParagraph(20, 25), function(err, result) {
        if (err) {
          return console.error(err);
        }
        data = result;
        return done();
      });
    });
    it('should have one data event', function() {
      return data.length.should.equal(1);
    });
    return it('should be a string', function() {
      return data[0].should.be.a('string');
    });
  });
});

describe('Number', function() {
  describe('7', function() {
    var data;
    data = [];
    before(function(done) {
      return test_stream_data(7, function(err, result) {
        if (err) {
          return console.error(err);
        }
        data = result;
        return done();
      });
    });
    it('should have one data event', function() {
      return data.length.should.equal(1);
    });
    it('should be a number', function() {
      return data[0].should.be.a('number');
    });
    return it('should equal 7', function() {
      return data[0].should.equal(7);
    });
  });
  return describe('Math.random()', function() {
    var data;
    data = [];
    before(function(done) {
      return test_stream_data(Math.random(), function(err, result) {
        if (err) {
          return console.error(err);
        }
        data = result;
        return done();
      });
    });
    it('should have one data event', function() {
      return data.length.should.equal(1);
    });
    return it('should be a number', function() {
      return data[0].should.be.a('number');
    });
  });
});

describe('Boolean', function() {
  return describe('true', function() {
    var data;
    data = [];
    before(function(done) {
      return test_stream_data(true, function(err, result) {
        if (err) {
          return console.error(err);
        }
        data = result;
        return done();
      });
    });
    it('should have one data event', function() {
      return data.length.should.equal(1);
    });
    it('should be a boolean', function() {
      return data[0].should.be.a('boolean');
    });
    return it('should equal true', function() {
      return data[0].should.equal(true);
    });
  });
});

describe('Buffer', function() {
  return describe('new Buffer("hello world")', function() {
    var data;
    data = [];
    before(function(done) {
      return test_stream_data(new Buffer('hello world'), function(err, result) {
        if (err) {
          return console.error(err);
        }
        data = result;
        return done();
      });
    });
    it('should have one data event', function() {
      return data.length.should.equal(1);
    });
    it('should be a buffer', function() {
      return Buffer.isBuffer(data[0]).should.equal(true);
    });
    return it('should contain string value "hello world"', function() {
      return data[0].toString().should.equal('hello world');
    });
  });
});

describe('Object', function() {
  describe('{}', function() {
    var data;
    data = [];
    before(function(done) {
      return test_stream_data({}, function(err, result) {
        if (err) {
          return console.error(err);
        }
        data = result;
        return done();
      });
    });
    it('should have one data event', function() {
      return data.length.should.equal(1);
    });
    return it('should be undefined', function() {
      return (data[0] === void 0).should.equal(true);
    });
  });
  describe('{hello: "world"}', function() {
    var data;
    data = [];
    before(function(done) {
      return test_stream_data({
        hello: 'world'
      }, function(err, result) {
        if (err) {
          return console.error(err);
        }
        data = result;
        return done();
      });
    });
    it('should have one data event', function() {
      return data.length.should.equal(1);
    });
    return it('should have one property "hello"', function() {
      return data[0].should.have.property('hello');
    });
  });
  return describe('{hello: "world", foo: "bar"}', function() {
    var data;
    data = [];
    before(function(done) {
      return test_stream_data({
        hello: 'world',
        foo: 'bar'
      }, function(err, result) {
        if (err) {
          return console.error(err);
        }
        data = result;
        return done();
      });
    });
    it('should have two data events', function() {
      return data.length.should.equal(2);
    });
    describe('event 1', function() {
      return it('should have one property "hello" with value "world"', function() {
        data[0].should.have.property('hello');
        return data[0].hello.should.equal('world');
      });
    });
    return describe('event 2', function() {
      return it('should have one property "foo" with value "bar"', function() {
        data[1].should.have.property('foo');
        return data[1].foo.should.equal('bar');
      });
    });
  });
});

describe('Array', function() {
  describe('[]', function() {
    var data;
    data = [];
    before(function(done) {
      return test_stream_data([], function(err, result) {
        if (err) {
          return console.error(err);
        }
        data = result;
        return done();
      });
    });
    it('should have one data event', function() {
      return data.length.should.equal(1);
    });
    return it('should be undefined', function() {
      return (data[0] === void 0).should.equal(true);
    });
  });
  return describe('["hello", "world"]', function() {
    var data;
    data = [];
    before(function(done) {
      return test_stream_data(['hello', 'world'], function(err, result) {
        if (err) {
          return console.error(err);
        }
        data = result;
        return done();
      });
    });
    it('should have two data events', function() {
      return data.length.should.equal(2);
    });
    describe('event 1', function() {
      return it('should be "hello"', function() {
        return data[0].should.equal('hello');
      });
    });
    return describe('event 2', function() {
      return it('should be "world"', function() {
        return data[1].should.equal('world');
      });
    });
  });
});
