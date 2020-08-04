'use strict';

var gulp = require('gulp');
var cssnano = require('gulp-cssnano');
var rename = require('gulp-rename');
var postcss = require('gulp-postcss');
var sourcemaps = require('gulp-sourcemaps');
var autoprefixer = require('autoprefixer');
var concat = require('gulp-concat');
var uglify = require('gulp-uglify');
var del = require('del');

// Gulp task to clean bundled CSS files
gulp.task('clean', function() {
  return del(['assets/**/bundle*']);
});

// Gulp task to minify and combine CSS files.
gulp.task('build:css', function() {
  return gulp.src(['_assets/css/**/*.css'])
        .pipe(sourcemaps.init())
        .pipe(cssnano())
        .pipe( postcss([ autoprefixer() ]) )
        .pipe(concat({path: 'bundle.min.css', cwd: ''}))
        .pipe(sourcemaps.write('.'))
        .pipe(gulp.dest('assets/css/'));
});

// Gulp task to minify and combine Javascript files.
gulp.task('build:js', function() {
  return gulp.src(['_assets/js/**/*.js'])
    .pipe(sourcemaps.init())
    .pipe(concat({path: 'bundle.min.js', cwd: ''}))
    .pipe(uglify())
    .pipe(sourcemaps.write('.'))
    .pipe(gulp.dest('assets/js/'));
});

// Gulp build task to build the CSS & JS.
gulp.task('build', gulp.series('build:css', 'build:js'));

// Gulp build task to clean the generated files and rebuild CSS & JS Build.
gulp.task('regenerate', gulp.series('clean', 'build:css', 'build:js'));

// Gulp task to lint the CSS styles in the codebase.
// It uses Stylelint under the hood.
gulp.task('lint:css', function lintCssTask() {
  const stylelint = require('gulp-stylelint');

  return gulp
    .src(['_assets/css/**/*.css'])
    .pipe(stylelint({
    reporters: [
      {formatter: 'verbose', console: true}
    ],
    debug: true,
    failAfterError: true
  }));
});

// Gulp task to lint the javascript in the codebase.
// It uses ESLint under the hood.
gulp.task('lint:js', function lintJSTask() {
  const eslint = require('gulp-eslint');

  return gulp
    .src(['_assets/js/**/*.js'])
    // eslint() attaches the lint output to the "eslint" property
    // of the file object so it can be used by other modules.
    .pipe(eslint({
      rules: {
        'no-unused-vars': ['error', { 'argsIgnorePattern': '^_', 'varsIgnorePattern': '^_' }]
      },
      globals: ['$']
    }))
    // eslint.format() outputs the lint results to the console.
    // Alternatively use eslint.formatEach() (see Docs).
    .pipe(eslint.format('stylish'))
    // To have the process exit with an error code (1) on
    // lint error, return the stream and pipe to failAfterError last.
    .pipe(eslint.failAfterError());
});

// Gulp build task to run the CSS & JS linters.
gulp.task('lint', gulp.series('lint:css', 'lint:js'));
