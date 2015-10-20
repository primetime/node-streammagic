# The module
do require './'

# Third party modules
lipsum = require('simple-lipsum')

# Testing libraries
mocha = require 'mocha'
chai = require 'chai'
chai.should()


test_stream_data = (data, callback) ->
	result = []
	data.toStream()
		.on 'data', (data) -> result.push data
		.on 'end', -> callback null, result
		.on 'error', (err) -> callback err


describe 'String', ->
	describe '"hello world"', ->
		data = []
		before (done) ->
			test_stream_data 'hello world', (err, result) ->
				return console.error err if err
				data = result
				do done

		it 'should have one data event', -> data.length.should.equal 1
		it 'should be a string', -> data[0].should.be.a 'string'
		it 'should contain "hello world"', -> data[0].should.equal 'hello world'

	describe 'a paragraph of lorem ipsum', ->
		data = []
		before (done) ->
			test_stream_data lipsum.getParagraph(20, 25), (err, result) ->
				return console.error err if err
				data = result
				do done

		it 'should have one data event', -> data.length.should.equal 1
		it 'should be a string', -> data[0].should.be.a 'string'


describe 'Number', ->
	describe '7', ->
		data = []
		before (done) ->
			test_stream_data 7, (err, result) ->
				return console.error err if err
				data = result
				do done

		it 'should have one data event', -> data.length.should.equal 1
		it 'should be a number', -> data[0].should.be.a 'number'
		it 'should equal 7', -> data[0].should.equal 7

	describe 'Math.random()', ->
		data = []
		before (done) ->
			test_stream_data Math.random(), (err, result) ->
				return console.error err if err
				data = result
				do done

		it 'should have one data event', -> data.length.should.equal 1
		it 'should be a number', -> data[0].should.be.a 'number'


describe 'Boolean', ->
	describe 'true', ->
		data = []
		before (done) ->
			test_stream_data true, (err, result) ->
				return console.error err if err
				data = result
				do done

		it 'should have one data event', -> data.length.should.equal 1
		it 'should be a boolean', -> data[0].should.be.a 'boolean'
		it 'should equal true', -> data[0].should.equal true


describe 'Buffer', ->
	describe 'new Buffer("hello world")', ->
		data = []
		before (done) ->
			test_stream_data new Buffer('hello world'), (err, result) ->
				return console.error err if err
				data = result
				do done

		it 'should have one data event', -> data.length.should.equal 1
		it 'should be a buffer', -> Buffer.isBuffer(data[0]).should.equal yes
		it 'should contain string value "hello world"', -> data[0].toString().should.equal 'hello world'


describe 'Object', ->
	describe '{}', ->
		data = []
		before (done) ->
			test_stream_data {}, (err, result) ->
				return console.error err if err
				data = result
				do done

		it 'should have one data event', -> data.length.should.equal 1
		it 'should be undefined', -> (data[0] is undefined).should.equal yes

	describe '{hello: "world"}', ->
		data = []
		before (done) ->
			test_stream_data {hello: 'world'}, (err, result) ->
				return console.error err if err
				data = result
				do done

		it 'should have one data event', -> data.length.should.equal 1
		it 'should have one property "hello"', -> data[0].should.have.property 'hello'

	describe '{hello: "world", foo: "bar"}', ->
		data = []
		before (done) ->
			test_stream_data {hello: 'world', foo: 'bar'}, (err, result) ->
				return console.error err if err
				data = result
				do done

		it 'should have two data events', -> data.length.should.equal 2

		describe 'event 1', ->
			it 'should have one property "hello" with value "world"', ->
				data[0].should.have.property 'hello'
				data[0].hello.should.equal 'world'
		describe 'event 2', ->
			it 'should have one property "foo" with value "bar"', ->
				data[1].should.have.property 'foo'
				data[1].foo.should.equal 'bar'


describe 'Array', ->
	describe '[]', ->
		data = []
		before (done) ->
			test_stream_data [], (err, result) ->
				return console.error err if err
				data = result
				do done

		it 'should have one data event', -> data.length.should.equal 1
		it 'should be undefined', -> (data[0] is undefined).should.equal yes

	describe '["hello", "world"]', ->
		data = []
		before (done) ->
			test_stream_data ['hello', 'world'], (err, result) ->
				return console.error err if err
				data = result
				do done

		it 'should have two data events', -> data.length.should.equal 2
		describe 'event 1', -> it 'should be "hello"', -> data[0].should.equal 'hello'
		describe 'event 2', -> it 'should be "world"', -> data[1].should.equal 'world'