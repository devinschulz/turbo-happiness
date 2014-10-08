gulp = require 'gulp'
$ = require('gulp-load-plugins')({ camelize: true })
ignore = require 'gulp-ignore'
pngcrush = require 'imagemin-pngcrush'
args = require('yargs').argv
path = require 'path'

# Environments
# To change environment add the --env=prod argument
DEVELOPMENT = 'dev'
PRODUCTION = 'prod'

config =
  environment : args.env || DEVELOPMENT
  root: './'
  sass_path: 'themes/idev/assets/sass/'
  css_path: 'themes/idev/static/css/'
  coffee_path: 'themes/idev/assets/coffee/'
  js_path: 'themes/idev/static/js/'
  libs_path: 'themes/idev/static/js/libs/'
  images_path: 'themes/idev/static/images/'
  sass_includes: [
    'themes/idev/assets/vendors/bourbon/dist/bourbon.scss'
    'themes/idev/assets/vendors/neat/app/assets/stylesheets/neat.scss'
    'themes/idev/assets/vendors/normalize-scss/normalize.scss'
  ],
  port: 35729

# Prepend sass path to includes
config.sass_includes.unshift config.sass_path

# Prepend the CWD to each SASS include (above)
config.sass_includes = config.sass_includes.map (includePath) ->
  path.join process.cwd(), includePath

onError = (err) ->
  $.util.beep()
  console.log err
  $.notify().write(err)

gulp.task('styles', ->
  gulp.src config.sass_path + 'style.scss'
    .pipe $.plumber
      errorHandler: onError
    .pipe $.scssLint()
    .pipe $.rubySass
      sourcemap: config.environment is not PRODUCTION
      trace: true
      precision: 10
      loadPath: config.sass_includes
      style: if config.environment is PRODUCTION then 'compressed' else 'expanded'
    .pipe gulp.dest config.root
    .pipe $.pleeease
      fallbacks:
        autoprefixer: ['last 4 versions', 'ie 8', 'ie 9', '> 5%']
      optimizers:
        minifier: if config.environment is PRODUCTION then true else false
      sourcemap: true
    .pipe $.if config.environment is PRODUCTION, $.combineMediaQueries
      log: true
    .pipe $.if config.environment is PRODUCTION, $.csscomb()
    .pipe $.if config.environment is PRODUCTION, $.compressor
      'compress-css': true,
      'remove-intertag-spaces': true
    .pipe $.if config.environment is PRODUCTION, $.cssshrink()
    .pipe gulp.dest config.css_path
    .pipe $.livereload()
)

# Scripts
gulp.task 'scripts', ->
  gulp.src config.coffee_path + '*.coffee'
    .pipe $.plumber
      errorHandler: onError
    .pipe $.coffeelint()
    .pipe $.coffeelint.reporter()
    .pipe $.coffee
      bare: true
    .pipe $.if config.environment is PRODUCTION, $.uglify()
    .pipe $.concat "scripts.js"
    .pipe gulp.dest config.js_path
    .pipe $.livereload()

gulp.task 'gulplint', ->
  gulp.src './gulpfile.coffee'
    .pipe $.plumber
      errorHandler: onError
    .pipe $.coffeelint('./coffeelint.json')
    .pipe $.coffeelint.reporter()

# Vendors
files = [

]

gulp.task 'move', ->
  if files.length
    gulp.src files
    .pipe gulp.dest config.libs_path

gulp.task 'vendors', ['move'], ->
  gulp.src(config.libs_path + '*.js')
  .pipe $.concat('plugins.js')
  .pipe $.if config.environment is PRODUCTION, $.uglify()
  .pipe gulp.dest config.js_path

# Images
gulp.task 'images', ->
  gulp.src config.images_path + '/**/*.{jpg, png, svg}'
    .pipe $.plumber
      errorHandler: onError
    .pipe $.cache $.imagemin
      interlaced: true
      progressive: true
      svgoPlugins:
        removeViewBox: false
      use:
        pngcrush()
    .pipe gulp.dest config.images_path
    .pipe $.livereload()

gulp.task 'default', ['gulplint', 'build'], ->
  $.livereload.listen()
  gulp.watch config.sass_path + '**/*.scss', ['styles']
  gulp.watch config.coffee_path + '*.coffee', ['scripts']
  gulp.watch config.images_path + '*.{jpg, png, svg}', ['images']
  gulp.watch(config.root + '**/*.html').on 'change', (file) ->
    $.livereload().changed(file.path)

gulp.task 'build', [
  'styles'
  'vendors'
  'scripts'
  'images'
]
