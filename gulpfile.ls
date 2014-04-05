#LiveScript gulp file
require! <[
  gulp
  gulp-clean
  gulp-less
  gulp-util
  gulp-livescript
]>

paths =
  scripts: <[app.ls ./routes/**/*.ls]>
  styles: './src/styles/**/*.less'
out =
  styles: './public/stylesheets'

gulp.task 'default' ['LiveScript', 'styles']

gulp.task 'LiveScript' ->
  gulp.src paths.scripts, base: './'
  .pipe gulp-livescript bare: true
  .on 'error' gulp-util.log
  .pipe gulp.dest './'

gulp.task 'styles' ['clean-styles'] ->
  gulp.src paths.styles
  .pipe gulp-less!
  .on 'error' gulp-util.log
  .pipe gulp.dest out.styles

gulp.task 'clean-styles' ->
  gulp.src out.styles, read: false
  .pipe gulp-clean!

gulp.task 'watch' ->
  gulp.watch paths.scripts, ['LiveScript']
  gulp.watch paths.styles, ['styles']
