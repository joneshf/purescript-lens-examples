'use strict'

var gulp       = require('gulp')
  , purescript = require('gulp-purescript')
  ;

var paths = {
    src: 'src/**/*.purs',
    bowerSrc: [
      'bower_components/purescript-*/src/**/*.purs',
      'bower_components/purescript-*/src/**/*.purs.hs'
    ],
    dest: '',
    docsDest: 'README.md'
};

var options = {
    compiler: {},
    pscDocs: {}
};

var compile = function(compiler) {
    var psc = compiler(options.compiler);
    psc.on('error', function(e) {
        console.error(e.message);
        psc.end();
    });
    return gulp.src([paths.src].concat(paths.bowerSrc))
        .pipe(psc)
        .pipe(gulp.dest(paths.dest));
};

gulp.task('make', function() {
    return compile(purescript.pscMake);
});

gulp.task('dotPsci', function() {
  gulp.src([paths.src].concat(paths.bowerSrc))
    .pipe(purescript.dotPsci());
});

gulp.task('browser', function() {
    return compile(purescript.psc);
});

gulp.task('docs', function() {
    var pscDocs = purescript.pscDocs(options.pscDocs);
    pscDocs.on('error', function(e) {
        console.error(e.message);
        pscDocs.end();
    });
    return gulp.src(paths.src)
      .pipe(pscDocs)
      .pipe(gulp.dest(paths.docsDest));
});

gulp.task('watch-browser', function() {
    gulp.watch(paths.src, ['browser', 'docs']);
});

gulp.task('watch-make', function() {
    gulp.watch(paths.src, ['make', 'dotPsci', 'docs']);
});

gulp.task('default', ['make', 'dotPsci', 'docs']);
