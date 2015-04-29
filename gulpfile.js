var gulp = require('gulp'),
    sourcemaps = require('gulp-sourcemaps'),
    autoprefixer = require('gulp-autoprefixer'),
    livereload = require('gulp-livereload');
var browserify = require('browserify');
var babelify = require("babelify");
var watchify = require('watchify');
var reactify = require('reactify');
var source = require('vinyl-source-stream');
var less = require('gulp-less');

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

gulp.task('mui_css', function () {
    gulp.src('./app/assets/stylesheets/app/material_ui/entry.less')
        .pipe(sourcemaps.init())
        .pipe(less())
        .pipe(autoprefixer({cascade: false, browsers: ['last 2 versions']}))
        .pipe(sourcemaps.write())
        .pipe(gulp.dest('./app/assets/stylesheets/app/material_ui'));
});

gulp.task('deploy_js', function () {
    browserify({
        entries: ['./app/assets/javascripts/app/entry.js'],
        transform: [babelify, reactify],
        debug: true,
        cache: {}, packageCache: {}, fullPaths: true
    }).bundle()
        .pipe(source('bundle.js'))
        .pipe(gulp.dest('./app/assets/javascripts/app'))
        .pipe(livereload());
    console.log('gulp deploy js successfully!');
});

gulp.task('deploy', ['deploy_js', 'mui_css']);

gulp.task('default', ['watch']);