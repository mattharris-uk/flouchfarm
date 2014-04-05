#LiveScript gulp file
require! <[
  gulp
  gulp-util
  gulp-livescript
]>

paths =
  scripts: <[app.ls ./routes/**/*.ls]>

gulp.task 'default' ['LiveScript']

gulp.task 'LiveScript' ->
  gulp.src paths.scripts, base: './'
  .pipe gulp-livescript bare: true
  .on 'error' gulp-util.log
  .pipe gulp.dest './'

gulp.task 'watch' ->
  gulp.watch paths.scripts, ['LiveScript']
