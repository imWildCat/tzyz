var gulp = require('gulp'),
    //sourcemaps = require('gulp-sourcemaps'),
    livereload = require('gulp-livereload');
var browserify = require('browserify');
var watchify = require('watchify');
var reactify = require('reactify');
var to5ify = require('6to5ify');
var source = require('vinyl-source-stream');

// TODO: add production config
// FIXME: sourcemap not working correctly

gulp.task("watch", function () {
    livereload.listen();

    var watcher = watchify(browserify({
        entries: ['./app/assets/javascripts/app/entry.js'],
        transform: [reactify],
        debug: true,
        cache: {}, packageCache: {}, fullPaths: true
    }));

    watcher.on('update', function () {
        watcher.transform(to5ify).bundle()
            .pipe(source('bundle.js'))
            .pipe(gulp.dest('./app/assets/javascripts/app'))
            .pipe(livereload());
        console.log('Updated');
    }).transform(to5ify).bundle()
        .pipe(source('bundle.js'))
        .pipe(gulp.dest('./app/assets/javascripts/app'))
        .pipe(livereload());
});

gulp.task('default', ['watch']);