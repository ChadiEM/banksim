fs = require 'fs'
{print} = require 'util'
{spawn, exec} = require 'child_process'


appFiles = [
]

# Helper functions that will build and watch
build = (watch, callback) ->
  if typeof watch is 'function'
    callback = watch
    watch = false
  options = ['-c', '-o', 'lib', 'src']
  options.unshift '-w' if watch

  coffee = spawn 'coffee', options
  coffee.stdout.on 'data', (data) -> print data.toString()
  coffee.stderr.on 'data', (data) -> print data.toString()
  coffee.on 'exit', (status) -> callback?() if status is 0


# Task to add coffe files unders in the array appFiles
task 'count', 'how much coffee you got?!', ->
  traverseFileSystem = (currentPath) ->
      files = fs.readdirSync currentPath
      for file in files
        do (file) ->
          currentFile = currentPath + '/' + file
          stats = fs.statSync(currentFile)
          if stats.isFile() and currentFile.indexOf('.coffee') > 1 and not ~appFiles.indexOf( currentFile )
            appFiles.push currentFile
          else if stats.isDirectory()
            traverseFileSystem currentFile
  traverseFileSystem 'src'
  return appFiles

# Generate Docs
task 'docs', 'Generate annotated source code with Docco', ->
	invoke 'count'
	codo = spawn 'codo', appFiles
	docco = spawn 'docco', appFiles
	docco.stderr.on 'data', (data) -> print data.toString()

	codo.on 'exit', (status) -> 
		# Put codo documentation inside docs
		exec 'rm -r ./docs/codo'
		exec 'mkdir ./docs/codo'
		exec 'mv ./doc/* ./docs/codo/', (err, stdout, stderr) ->
			throw err if err
			exec 'rm -r ./doc'
		callback?() if status is 0
	docco.on 'exit', (status) -> 
		# Put docco documentation inside docs
		exec 'mkdir ./docs/docco'
		exec 'mv ./docs/*html ./docs/docco/', (err, stdout, stderr) ->
			throw err if err
		exec 'mv ./docs/*css ./docs/docco/', (err, stdout, stderr) ->
			throw err if err
		callback?() if status is 0

task 'build', 'Compile CoffeeScript source files', ->
  build()

task 'watch', 'Recompile CoffeeScript source files when modified', ->
  build true

task 'test', 'Run the test suite', ->
  build ->
    require.paths.unshift __dirname + "/lib"
    {reporters} = require 'nodeunit'
    process.chdir __dirname
    reporters.default.run ['test']
