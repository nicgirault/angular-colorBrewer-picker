var gulp = require('gulp');
var less = require('gulp-less')
var coffee = require('gulp-coffee');
var browserify = require('gulp-browserify');
var rename = require('gulp-rename');
var jade = require('gulp-jade');

gulp.task('coffee', function(){
  gulp.src('src/**/*.coffee')
  .pipe(coffee({bare: true}))
  .pipe(gulp.dest('build'))
});

gulp.task('browserify', ['coffee'], function() {
  gulp.src('build/module.js')
  .pipe(browserify())
  .pipe(rename('colorBrewer.js'))
  .pipe(gulp.dest('dist'))
});

gulp.task('jade', function() {
  gulp.src('src/**/*.jade')
  .pipe(jade())
  .pipe(gulp.dest('demo'))
});

gulp.task('build', [ 'browserify', 'jade']);
