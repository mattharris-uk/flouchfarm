#LiveScript gulp file
require! <[
  component-jade
  component-livescript
  gulp
  gulp-clean
  gulp-component
  gulp-less
  gulp-livescript
  gulp-replace
  gulp-util
]>

paths =
  scripts: <[app.ls ./routes/**/*.ls]>
  styles: ['./src/styles/**/*.less' './src/bootstrap/bootstrap.less']
  components: ['./src/components/component.json' './src/components/local/**/*']
  component-json: './src/components/component.json'
out =
  styles: './public/stylesheets'
  components: './public/javascripts/components'

gulp.task 'default' ['LiveScript' 'styles' 'components']

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

gulp.task 'clean-components' ->
  gulp.src out.components, read: false
  .pipe gulp-clean!

gulp.task 'components' ['clean-components'] ->
  gulp.src paths.component-json
  .pipe gulp-component do
    name: 'main'
    use: [component-livescript, component-jade]
  .pipe gulp-replace /\.ls"/g, '.js"'
  .pipe gulp.dest out.components

gulp.task 'watch' ['default'] ->
  gulp.watch paths.scripts, ['LiveScript']
  gulp.watch paths.styles, ['styles']
  gulp.watch paths.components, ['components']
