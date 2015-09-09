exec = require('child_process').exec
gulp = require 'gulp'
sequence = require 'run-sequence'

env =
  dev: true
  main: '//localhost:8080/build/main.js'
  style: '//localhost:8080/build/style.css'
  vendor: '//localhost:8080/build/vendor.js'

gulp.task 'script', ->
  coffee = require 'gulp-coffee'
  gulp
  .src 'src/**/*.coffee'
  .pipe coffee()
  .pipe gulp.dest 'lib/'

gulp.task 'rsync', (cb) ->
  wrapper = require 'rsyncwrapper'
  wrapper.rsync
    ssh: true
    src: ['index.html', 'build']
    recursive: true
    args: ['--verbose']
    dest: 'talk-ui:/teambition/server/talk-ui/react-lite-layered'
    deleteAll: true
  , (error, stdout, stderr, cmd) ->
    if error?
      throw error
    console.error stderr
    console.log cmd
    cb()

gulp.task 'html', (cb) ->
  require 'cirru-script/lib/register'
  html = require './template.cirru'
  fs = require 'fs'
  unless env.dev
    assets = require './build/assets.json'
    env.main = './build/' + assets.main[0]
    env.style = './build/' + assets.main[1]
    env.vendor = './build/' + assets.vendor

  fs.writeFile 'index.html', html(env), cb

gulp.task 'del', (cb) ->
  del = require 'del'
  del [ 'build' ], cb

gulp.task 'webpack', (cb) ->
  if env.dev
    command = 'webpack'
  else
    command = 'webpack --config webpack.min.coffee --progress'
  exec command, (err, stdout, stderr) ->
    console.log stdout
    console.log stderr
    cb err

gulp.task 'build', (cb) ->
  env.dev = false
  sequence 'del', 'webpack', 'html', cb
