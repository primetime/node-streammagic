# Stream Magic
Converts any variable into a stream

## What it does
Stream Magic extends the prototypes of all variable types within Node.JS with a `.toStream()` method, which lets you easily transform objects and variables into streams.

A safe mode that doesn't extend prototypes is also available.

#### Installation
You can install Stream Magic using NPM

```
$ npm install streammagic
```

#### Usage
Essentially the module is just one function that attatches the `.toStream()` method to the prototypes. So to use it, simply require it and run the function once.
```Javascript
require('streammagic')();
```

Once this is done, the `.toStream()` method should be available on all variables.

```Javascript
// Logs 'hello world' to stdout (the console)
var myString = 'hello world';
var myStream = myString.toStream();
myStream.pipe(process.stdout);

// Or shorter
'hello world'.toStream().pipe(process.stdout)
```

#### Safe mode
The safe mode is available as a method of the module. Simply require it like this:

```Javascript
var toStream = require('streammagic').toStream;

// Same as above
var myString = 'hello world';
var myStream = toStream(myString);
myStream.pipe(process.stdout);

// Short version
toStream('hello world').pipe(process.stdout);
```

## Datatypes

#### Primitive datatypes
All primitive datatypes (number, boolean, string) will be pushed to the stream in one piece. This cause a slight performance loss for long strings, depending on the actions of the subsequent pipes. _This is something that may be addressed later on_.

```Javascript
// Boolean
var stream = false.toStream() // stream.on('data') will contain: false

// Number
var stream = (35).toStream() // stream.on('data') will contain: 35

// String
var stream = 'foo'.toStream() // stream.on('data') will contain: foo
```


#### Arrays
Arrays will be piped one item at a time. This can be useful e.g. for processing large sets of data.

```Javascript
var myArray = ['hello', 'world'];
var myStream = myArray.toStream();

myStream.on('data', function(data){
	// The data event will fire twice. Data will contain 'hello' the first time, 'world' the second.
});
```


#### Objects
Objects are piped one property at a time as `{key: value}` objects. Keep this in mind, as assembling the original object on the other end of the pipe will require some manual work.

```Javascript
var myObject = {
	hello: 'world',
	foo: 'bar'
};
var myStream = myObject.toStream();

myStream.on('data', function(data){
	// The data event will fire twice. Data will contain {hello: 'world'} the first time, {foo: 'bar'} the second.
});
```

###### Hint

If you need an object or an array to be piped as one instead of being split up, you can simply wrap it inside another array. Only the outermost array or object will be split.

```Javascript
var myArray = ['hello', 'world'];
var myStream = [myArray].toStream();

myStream.on('data', function(data){
	console.log(data); // ['hello', 'world']
});
```

#### Buffers
Node buffers will be piped as they are, just like primitive datatypes.

## Issues
If you find any problems with this module, please [create an issue](https://github.com/INXCO/node-streammagic/issues) so we can look into it. Pull requests with bugfixes are of course welcome.

## License
This module is licensed under the MIT License.
