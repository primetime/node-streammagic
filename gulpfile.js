const gulp = require('gulp');
const plumber = require('gulp-plumber');

const coffee = require('gulp-coffee');


// Compiles coffeescript to javascript
gulp.task('compile', function(){
	gulp.src('./src/*.coffee')
		.pipe(plumber())
		.pipe(coffee({bare: true}))
		.pipe(gulp.dest('./dist'));
});


// Watches for file changes
gulp.task('default', ['compile'], function(){
	gulp.watch('./src/*.coffee', ['compile']);
});
