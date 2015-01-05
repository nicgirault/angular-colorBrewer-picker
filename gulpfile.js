var gulp = require('gulp');
var less = require('gulp-less')
var coffee = require('gulp-coffee');
var browserify = require('gulp-browserify');
var rename = require('gulp-rename');

gulp.task('coffee', function(){
  gulp.src('src/**/*.coffee')
  .pipe(coffee({bare: true}))
  .pipe(gulp.dest('build'))
});

gulp.task('browserify', ['coffee'], function() {
  gulp.src('build/colorBrewer.module.js')
  .pipe(browserify())
  .pipe(rename('colorBrewer.js'))
  .pipe(gulp.dest('dist'))
});

gulp.task('less', function(){
  gulp.src('src/style.less')
  .pipe(less())
  .pipe(rename('colorBrewer.css'))
  .pipe(gulp.dest('dist'))
});

gulp.task('build', [ 'browserify', 'less']);
