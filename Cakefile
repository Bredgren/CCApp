fs = require 'fs'

{print} = require 'sys'
{spawn, exec} = require 'child_process'

findFilesUnderDirectory = (dir) ->
  results = []
  list = fs.readdirSync("#{__dirname}\\#{dir}")
  for file in list then do (file) ->
    file = "#{dir}\\#{file}"
    stat = fs.statSync(file)
    if stat and stat.isDirectory()
      results = results.concat(findFilesUnderDirectory(file))
    else
      results.push(file) if /.coffee$/.test(file)
  return results

createTmpDir = () ->
  if not fs.existsSync("#{__dirname}\\coffee\\tmp")
    fs.mkdirSync("#{__dirname}\\coffee\\tmp")
  print "created temporary directory\n\n"

removeTmpDir = () ->
  files = findFilesUnderDirectory("coffee\\tmp")
  for file in files
    fs.unlinkSync("#{__dirname}\\#{file}")
  fs.rmdirSync("#{__dirname}\\coffee\\tmp")

  print "removed temporary directory\n"

fileListToString = (list) ->
  string = list.join(" ")
  return string.replace(/\\/g, "/")

concatenateAndCompile = (files, dest, target_folder, target_file, callback) ->
  print "combining files #{files} into #{dest}\n"
  exec("coffeescript-concat #{files} -o #{dest}",
    (err, stdout, stderr) ->
      if err
        print "FAIL concat error: #{err}\n"
      else
        print "compiling #{dest} into #{target_file}\n"

      exec("coffee -c -o #{target_folder} --join #{target_file} #{dest}",
        (err, stdout, stderr) ->
          if err
            print "FAIL compile error: #{err}\n\n"
          else
            print "SUCCESS #{target_file} successfully created\n\n"
          callback()
      )
  )

# add debug option...

buildAll = (callback) ->
  buildUi(() -> buildApp(() ->  callback()))

buildUi = (callback) ->
  print "building ui...\n"

  files = fileListToString(findFilesUnderDirectory("coffee\\ui"))
  dest = "coffee/tmp/ui_tmp.coffee"
  target_folder = "lib/"
  target_file = "ui.js"

  concatenateAndCompile(files, dest, target_folder, target_file, callback)

buildApp = (callback) ->
  print "building app...\n"

  files = fileListToString(findFilesUnderDirectory("coffee\\app"))
  dest = "coffee/tmp/main_tmp.coffee"
  target_folder = "js/"
  target_file = "main.js"

  concatenateAndCompile(files, dest, target_folder, target_file, callback)

task 'build:all', 'Builds all coffee scripts', ->
  createTmpDir()
  buildAll(() -> removeTmpDir())

task 'build:ui', 'Builds all ui coffee scrips into lib/ui.js', ->
  createTmpDir()
  buildUi(() -> removeTmpDir())

task 'build:app', 'Build all app coffee scripts into js/main.js', ->
  createTmpDir()
  buildApp(() -> removeTmpDir())
