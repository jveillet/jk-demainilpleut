'use strict';

var gulp = require('gulp');
var cssnano = require('gulp-cssnano');
var rename = require('gulp-rename');
var postcss = require('gulp-postcss');
var sourcemaps = require('gulp-sourcemaps');
var autoprefixer = require('autoprefixer');

var CSS_DEST = 'css';

gulp.task('default', function() {
  // place code for your default task here
  return gulp.src('css/style.css')
        .pipe(sourcemaps.init())
        .pipe(cssnano())
        .pipe(rename({ extname: '.min.css' }))
        .pipe( postcss([ autoprefixer({ browsers: ['last 4 versions'] }) ]) )
        .pipe(sourcemaps.write('.'))
        .pipe(gulp.dest(CSS_DEST));
});

gulp.task('lint-css', function lintCssTask() {
  const gulpStylelint = require('gulp-stylelint');

  return gulp
    .src('css/style-dark.css')
    .pipe(gulpStylelint({
    reporters: [
      {formatter: 'string', console: true}
    ]
  }));
});
