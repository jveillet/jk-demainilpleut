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
  return gulp.src('*.css')
        .pipe(sourcemaps.init())
        .pipe(cssnano())
        .pipe(rename({ extname: '.min.css' }))
        .pipe( postcss([ autoprefixer({ browsers: ['last 2 versions'] }) ]) )
        .pipe(sourcemaps.write('.'))
        .pipe(gulp.dest(CSS_DEST));
});
