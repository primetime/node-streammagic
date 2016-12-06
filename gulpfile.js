var gulp = require('gulp');
var coffee = require('gulp-coffee');
var plumber = require('gulp-plumber');

// Compiles coffeescript to javascript
gulp.task('compile', function(){
	gulp.src('./src/*.coffee')
		.pipe(plumber())
		.pipe(coffee({bare: true}))
		.pipe(gulp.dest('./'));
});

// Watches for file changes
gulp.task('default', ['compile'], function(){
	gulp.watch('./src/*.coffee', ['compile']);
});
