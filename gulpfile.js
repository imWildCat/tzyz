var gulp = require('gulp'),
    //sourcemaps = require('gulp-sourcemaps'),
    livereload = require('gulp-livereload');
var browserify = require('browserify');
var babelify = require("babelify");
var watchify = require('watchify');
var reactify = require('reactify');
var source = require('vinyl-source-stream');

// TODO: add production config
// FIXME: sourcemap not working correctly

gulp.task("watch", function () {
    livereload.listen();

    var watcher = watchify(browserify({
        entries: ['./app/assets/javascripts/app/entry.js'],
        transform: [babelify, reactify],
        debug: true,
        cache: {}, packageCache: {}, fullPaths: true
    }));

    watcher.on('update', function () {
        watcher.bundle()
            .pipe(source('bundle.js'))
            .pipe(gulp.dest('./app/assets/javascripts/app'))
            .pipe(livereload());
        console.log('Updated');
    }).bundle()
        .pipe(source('bundle.js'))
        .pipe(gulp.dest('./app/assets/javascripts/app')).pipe(livereload());
});

gulp.task('deploy', function() {
    browserify({
        entries: ['./app/assets/javascripts/app/entry.js'],
        transform: [babelify, reactify],
        debug: true,
        cache: {}, packageCache: {}, fullPaths: true
    }).bundle()
        .pipe(source('bundle.js'))
        .pipe(gulp.dest('./app/assets/javascripts/app'))
        .pipe(livereload());
    console.log('gulp deploy successfully!');
});

gulp.task('default', ['watch']);