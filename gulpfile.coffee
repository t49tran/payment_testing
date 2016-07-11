fs = require('fs')
config = JSON.parse(fs.readFileSync('./gulp_local_config.json'))
gulp = require('gulp')
concat = require('gulp-concat')
uglify = require('gulp-uglify')
rename = require('gulp-rename')
path = require('path')
jshint = require('gulp-jshint')
coffee = require('gulp-coffee')
templateCache = require('gulp-angular-templatecache')
stylus = require('gulp-stylus')
uglifycss = require('gulp-uglifycss')
scp = require('gulp-scp2')

gulp.Gulp.prototype.__runTask = gulp.Gulp.prototype._runTask;
gulp.Gulp.prototype._runTask = (task)->
  @.currentTask = task;
  @.__runTask(task);

gulp.task 'combine-vendor', ()->
    gulp.src(config.js_vendors)
    .pipe(concat('vendors.js'))
    .pipe(gulp.dest(config.compiled_js_dest));

    gulp.src(config.css_vendors)
    .pipe(concat("vendors.css"))
    .pipe(gulp.dest(config.compiled_css_dest));

for  taskName of config.coffee_tasks
  gulp.task(taskName, ()->
    task = config.coffee_tasks[@.currentTask.name]
    gulp.src(config.coffee_dir+task.src)
      .pipe(coffee({bare:true}).on("error",(err)->
        console.log err
      ))
      #.pipe(uglify())
      .pipe(concat(task.dest))
      .pipe(gulp.dest(config.compiled_js_dest))
  )

for  taskName of config.stylus_tasks
  gulp.task(taskName, ()->
    task = config.stylus_tasks[@.currentTask.name]
    gulp.src(config.stylus_dir+task.src)
    .pipe(stylus().on("error",(err)->
        console.log err
    ))
    .pipe(uglifycss())
    .pipe(concat task.dest)
    .pipe(gulp.dest(config.compiled_css_dest))
  )


gulp.task('inject-template-js',()->
  gulp.src(config.template_dir+'/*.html')
  .pipe(templateCache({module:'paymentTestingApp',filename:'payment_testing_templates.js'}))
  .pipe(gulp.dest(config.compiled_js_dest));
)

gulp.task('app-watch', ()->
  for taskName of config.coffee_tasks
    task = config.coffee_tasks[taskName]
    if task.watchable
      gulp.watch(config.coffee_dir+task.src,[taskName])


  for taskName of config.stylus_tasks
    task = config.stylus_tasks[taskName]
    if task.watchable
      gulp.watch(config.stylus_dir+task.src,[taskName])

  gulp.watch(config.template_dir+'/*.html',['inject-template-js'])
)

gulp.task('build-js',()->

)

gulp.task('build-css',()->

)

gulp.task('default', ['combine-vendor','app-watch']);
