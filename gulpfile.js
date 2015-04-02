var fs = require('fs');
var gulp = require('gulp');
var concat = require('gulp-concat');
var rename = require('gulp-rename');
var es = require('event-stream');
var del = require('del');
var uglify = require('gulp-uglify');
var minifyHtml = require('gulp-minify-html');
var minifyCss = require('gulp-minify-css');
var templateCache = require('gulp-angular-templatecache');
var gutil = require('gulp-util');
var plumber = require('gulp-plumber');//To prevent pipe breaking caused by errors at 'watch'
var coffee = require('gulp-coffee')
var jade = require('gulp-jade')

gulp.task('watch', ['style'], function() {
  gulp.watch(['src/**/*.{js,jade,coffee,css}'], ['style']);
});

gulp.task('clean', function(cb) {
  del(['dist', 'build'], cb);
});

gulp.task('coffee', function() {
  return gulp.src(['src/module.coffee', 'src/services/*.coffee', 'src/directives/*.coffee'])
    .pipe(concat('tmp.coffee'))
    .pipe(coffee({bare: true}))
    .pipe(gulp.dest('build'));
});

gulp.task('build', ['clean', 'coffee'], function() {

  var buildTemplates = function () {
    return gulp.src('src/templates/*.jade')
      .pipe(jade())
      .pipe(minifyHtml({
             empty: true,
             spare: true,
             quotes: true
            }))
      .pipe(templateCache({module: 'colorBrewer'}));
  };

  var buildLib = function(){
    return gulp.src(['build/tmp.js', 'src/ui-select/select.js'])
      .pipe(concat('select_without_templates.js'))
  };

  return es.merge(buildLib(), buildTemplates())
    .pipe(plumber({
      errorHandler: handleError
    }))
    .pipe(concat('angular-color-brewer-picker.js'))
    .pipe(gulp.dest('dist'))
    .pipe(uglify())
    .pipe(rename('angular-color-brewer-picker.min.js'))
    .pipe(gulp.dest('dist'));

});

gulp.task('style', ['build'], function(){
  return gulp.src(['src/style.css'])
    .pipe(rename('angular-color-brewer-picker.css'))
    .pipe(gulp.dest('dist'))
    .pipe(minifyCss())
    .pipe(rename('angular-color-brewer-picker.min.css'))
    .pipe(gulp.dest('dist'));
});

gulp.task('default', ['style']);

var handleError = function (err) {
  console.log(err.toString());
  this.emit('end');
};
