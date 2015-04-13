var gulp = require('gulp'),
    webpack = require('gulp-webpack');

gulp.task("webpack", function() {
    return gulp.src("app/assets/javascripts/app/entry.js")
        .pipe(webpack(require("./config/webpack.config.js")))
        .pipe(gulp.dest("app/assets/javascripts/app"));
});

gulp.task("watch", function() {
    gulp.watch(["app/assets/javascripts/app/**/*.js", "!app/assets/javascripts/app/bundle.js", "app/assets/javascripts/app/**/*.jsx"], ["webpack"]);
});

gulp.task("default", ["watch", "webpack"]);