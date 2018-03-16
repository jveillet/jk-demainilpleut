'use strict';

var gulp = require('gulp');
var cssnano = require('gulp-cssnano');
var rename = require('gulp-rename');
var postcss = require('gulp-postcss');
var sourcemaps = require('gulp-sourcemaps');
var autoprefixer = require('autoprefixer');
var concat = require('gulp-concat');

var CSS_DEST = 'css';

gulp.task('build', function() {
  // Build the CSS and minify it
  return gulp.src(['styles/**/*.css', '!styles/vendor/**/*.css', '!styles/**/*.css.map', '!styles/**/*.min.css'])
        .pipe(sourcemaps.init())
        .pipe(cssnano())
        .pipe( postcss([ autoprefixer({ browsers: ['last 4 versions'] }) ]) )
        .pipe(concat('../css/bundle.min.css'))
        .pipe(sourcemaps.write('.'))
        .pipe(gulp.dest(CSS_DEST));
});

gulp.task('lint-css', function lintCssTask() {
  const gulpStylelint = require('gulp-stylelint');

  return gulp
    .src(['styles/**/*.css', '!styles/vendor/**/*.css', '!styles/**/*.css.map', '!styles/**/*.min.css'])
    .pipe(gulpStylelint({
    reporters: [
      {formatter: 'verbose', console: true}
    ],
    debug: true,
    failAfterError: true
  }));
});
