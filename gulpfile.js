const gulp = require('gulp');
const plumber = require('gulp-plumber');

const coffee = require('gulp-coffee');
const sourcemaps = require('gulp-sourcemaps');


// Compiles coffeescript to javascript
gulp.task('compile', function(){
	gulp.src('./src/*.coffee')
		.pipe(plumber())
		.pipe(coffee({bare: true}))
		.pipe(gulp.dest('./dist'));
});

gulp.task('compile-sourcemaps', function(){
	gulp.src('./src/*.coffee')
		.pipe(plumber())
		.pipe(sourcemaps.init())
		.pipe(coffee({bare: true}))
		.pipe(sourcemaps.mapSources(function(sourcePath){ return '../src/' + sourcePath; }))
		.pipe(sourcemaps.write())
		.pipe(gulp.dest('./dist'));
})

// Watches for file changes
gulp.task('default', ['compile'], function(){
	gulp.watch('./src/*.coffee', ['compile']);
});
