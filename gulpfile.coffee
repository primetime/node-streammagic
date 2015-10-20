gulp = require 'gulp'
gutil = require 'gulp-util'
coffee = require 'gulp-coffee'

# Compiles coffeescript to javascript
gulp.task 'compile', ->
	gulp.src './src/*.coffee'
		.pipe coffee(bare: yes).on('error', gutil.log)
		.pipe gulp.dest('./')
		.on 'error', gutil.log


# Starts nodemon and watches for file changes
gulp.task 'default', ['compile'], ->
	gulp.watch './src/*.coffee', ['compile']