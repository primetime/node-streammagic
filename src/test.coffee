# Require the module
streammagic = require('./')

# Simple-lipsum to generate dummy content
lipsum = require('simple-lipsum')

# Testing library
tap = require('tap')


# Helper function to test a stream
testStream = (stream, callback) ->
	result = []
	stream.on 'data', (data) -> result.push data
	stream.on 'end', -> callback null, result
	stream.on 'error', (err) -> callback err


# Test safe mode
tap.test 'safe mode', (t) ->


	t.test 'string', (t) ->

		t.test 'hello world', (t) ->
			t.plan(3)

			stream = streammagic.toStream('hello world')
			testStream stream, (err, data) ->
				t.error(err)
				t.equals(data.length, 1, 'should have one data event')
				t.equals(data[0], 'hello world', 'should return hello world')

		t.test 'lorem ipsum', (t) ->
			t.plan(3)

			stream = streammagic.toStream(lipsum.getParagraph(20, 25))
			testStream stream, (err, data) ->
				t.error(err)
				t.equals(data.length, 1, 'should have one data event')
				t.type(data[0], 'string', 'should contain a string')


	t.test 'number', (t) ->

		t.test '7', (t) ->
			t.plan(3)

			stream = streammagic.toStream(7)
			testStream stream, (err, data) ->
				t.error(err)
				t.equals(data.length, 1, 'should have one data event')
				t.equals(data[0], 7, 'should contain 7')

		t.test 'random number', (t) ->
			t.plan(3)

			stream = streammagic.toStream(Math.random())
			testStream stream, (err, data) ->
				t.error(err)
				t.equals(data.length, 1, 'should have one data event')
				t.type(data[0], 'number', 'should contain a number')


	t.test 'boolean', (t) ->
		t.plan(3)

		stream = streammagic.toStream(true)
		testStream stream, (err, data) ->
			t.error(err)
			t.equals(data.length, 1, 'should have one data event')
			t.equals(data[0], true, 'should contain true')


	t.test 'buffer', (t) ->
		t.plan(4)

		stream = streammagic.toStream(new Buffer('hello world'))
		testStream stream, (err, data) ->
			t.error(err)
			t.equals(data.length, 1, 'should have one data event')
			t.true(Buffer.isBuffer(data[0]), 'should be a buffer')
			t.equals(data[0].toString(), 'hello world', 'should contain hello world')


	t.test 'object', (t) ->

		t.test 'empty object', (t) ->
			t.plan(3)

			t.comment('{}')
			stream = streammagic.toStream({})
			testStream stream, (err, data) ->
				t.error(err)
				t.equals(data.length, 1, 'should have one data event')
				t.equals(data[0], undefined, 'should contain undefined')


		t.test 'hello world object', (t) ->
			t.plan(4)

			t.comment('{hello: world, foo: bar}')
			stream = streammagic.toStream(hello: 'world', foo: 'bar')
			testStream stream, (err, data) ->
				t.error(err)
				t.equals(data.length, 2, 'should have two data events')
				t.same(data[0], (hello: 'world'), 'should contain {hello: world} in first value')
				t.same(data[1], (foo: 'bar'), 'should contain {foo: bar} in second value')


		t.test 'array', (t) ->

			t.test 'empty array', (t) ->
				t.plan(3)

				t.comment('[]')
				stream = streammagic.toStream([])
				testStream stream, (err, data) ->
					t.error(err)
					t.equals(data.length, 1, 'should have one data event')
					t.equals(data[0], undefined, 'should contain undefined')

			t.test 'hello world array', (t) ->
				t.plan(4)

				t.comment('[hello, world]')
				stream = streammagic.toStream(['hello', 'world'])
				testStream stream, (err, data) ->
					t.error(err)
					t.equals(data.length, 2, 'should have two data events')
					t.equals(data[0], 'hello', 'should contain hello in first value')
					t.equals(data[1], 'world', 'should contain world in second value')


# Extend prototypes
tap.test 'extend prototype', (t) ->
	do streammagic

	t.test 'string', (t) ->

		t.test 'hello world', (t) ->
			t.plan(3)

			stream = 'hello world'.toStream()
			testStream stream, (err, data) ->
				t.error(err)
				t.equals(data.length, 1, 'should have one data event')
				t.equals(data[0], 'hello world', 'should return hello world')

		t.test 'lorem ipsum', (t) ->
			t.plan(3)

			stream = lipsum.getParagraph(20, 25).toStream()
			testStream stream, (err, data) ->
				t.error(err)
				t.equals(data.length, 1, 'should have one data event')
				t.type(data[0], 'string', 'should contain a string')


	t.test 'number', (t) ->

		t.test '7', (t) ->
			t.plan(3)

			stream = 7.toStream()
			testStream stream, (err, data) ->
				t.error(err)
				t.equals(data.length, 1, 'should have one data event')
				t.equals(data[0], 7, 'should contain 7')

		t.test 'random number', (t) ->
			t.plan(3)

			stream = Math.random().toStream()
			testStream stream, (err, data) ->
				t.error(err)
				t.equals(data.length, 1, 'should have one data event')
				t.type(data[0], 'number', 'should contain a number')


	t.test 'boolean', (t) ->
		t.plan(3)

		stream = true.toStream()
		testStream stream, (err, data) ->
			t.error(err)
			t.equals(data.length, 1, 'should have one data event')
			t.equals(data[0], true, 'should contain true')


	t.test 'buffer', (t) ->
		t.plan(4)

		stream = new Buffer('hello world').toStream()
		testStream stream, (err, data) ->
			t.error(err)
			t.equals(data.length, 1, 'should have one data event')
			t.true(Buffer.isBuffer(data[0]), 'should be a buffer')
			t.equals(data[0].toString(), 'hello world', 'should contain hello world')


	t.test 'object', (t) ->

		t.test 'empty object', (t) ->
			t.plan(3)

			t.comment('{}')
			stream = {}.toStream()
			testStream stream, (err, data) ->
				t.error(err)
				t.equals(data.length, 1, 'should have one data event')
				t.equals(data[0], undefined, 'should contain undefined')


		t.test 'hello world object', (t) ->
			t.plan(4)

			t.comment('{hello: world, foo: bar}')
			stream = (hello: 'world', foo: 'bar').toStream()
			testStream stream, (err, data) ->
				t.error(err)
				t.equals(data.length, 2, 'should have two data events')
				t.same(data[0], (hello: 'world'), 'should contain {hello: world} in first value')
				t.same(data[1], (foo: 'bar'), 'should contain {foo: bar} in second value')


		t.test 'array', (t) ->

			t.test 'empty array', (t) ->
				t.plan(3)

				t.comment('[]')
				stream = [].toStream()
				testStream stream, (err, data) ->
					t.error(err)
					t.equals(data.length, 1, 'should have one data event')
					t.equals(data[0], undefined, 'should contain undefined')

			t.test 'hello world array', (t) ->
				t.plan(4)

				t.comment('[hello, world]')
				stream = ['hello', 'world'].toStream()
				testStream stream, (err, data) ->
					t.error(err)
					t.equals(data.length, 2, 'should have two data events')
					t.equals(data[0], 'hello', 'should contain hello in first value')
					t.equals(data[1], 'world', 'should contain world in second value')
