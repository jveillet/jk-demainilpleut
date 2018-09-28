'use strict';

var gulp = require('gulp');
var cssnano = require('gulp-cssnano');
var rename = require('gulp-rename');
var postcss = require('gulp-postcss');
var sourcemaps = require('gulp-sourcemaps');
var autoprefixer = require('autoprefixer');
var concat = require('gulp-concat');
var uglify = require('gulp-uglify');

var CSS_DEST = 'css';
var JS_DEST = 'js';

// Gulp task to minify and combine CSS files.
gulp.task('build:css', function() {
  return gulp.src(['styles/**/*.css', '!styles/vendor/**/*.css', '!styles/**/*.css.map', '!styles/**/*.min.css'])
        .pipe(sourcemaps.init())
        .pipe(cssnano())
        .pipe( postcss([ autoprefixer({ browsers: ['last 4 versions'] }) ]) )
        .pipe(concat('../css/bundle.min.css'))
        .pipe(sourcemaps.write('.'))
        .pipe(gulp.dest(CSS_DEST));
});

// Gulp task to minify and combine Javascript files.
gulp.task('build:js', function() {
  return gulp.src(['js/dnt-helper.js', 'js/scripts.js'])
    .pipe(concat('bundle.min.js'))
    .pipe(uglify())
    .pipe(gulp.dest(JS_DEST));
});

// Guil build task to run the CSS & JS Build.
gulp.task('build', gulp.series('build:css', 'build:js'));

// Gulp task to lint the CSS styles in the project.
// It uses Stylelint under the hood.
gulp.task('lint:css', function lintCssTask() {
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

