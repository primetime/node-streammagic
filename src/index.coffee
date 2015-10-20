# Readable - the basis of our streams
Readable = require('stream').Readable

# class Stream
#   new Stream ( data )
#   creates a stream from a variable
class Stream extends Readable
	constructor: (data) ->
		if typeof data is 'object' and not Buffer.isBuffer data
			if Array.isArray(data)
				@data = data
			else
				@data = []
				for i, j of data
					o = {}
					o[i] = j
					@data.push o
			
		else @data = data

		Readable.call this, objectMode: yes

	_read: ->
		if Array.isArray(@data)
			@push @data.splice(0, 1)[0]
			if @data.length is 0
				@push null
		else if Buffer.isBuffer(@data)
			@push new Buffer @data
			@push null
		else
			@push @data
			@push null

# Extend the prototypes
module.exports = ->

	# Primitive types require .valueOf() to get their primitive value, otherwise they will be evaluated as objects
	for i in [Boolean, Number, String]
		Object.defineProperty i.prototype, 'toStream',
			value: -> new Stream this.valueOf()
			writable: false
			configurable: false
			enumerable: false

	for i in [Array, Buffer, Object]
		Object.defineProperty i.prototype, 'toStream',
			value: -> new Stream this
			writable: false
			configurable: false
			enumerable: false