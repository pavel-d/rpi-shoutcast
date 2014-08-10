# Cakefile
{spawn, exec} = require 'child_process'

REPORTER = 'spec'

task 'test', 'run tests', ->
  exec "NODE_ENV=test mocha -R #{REPORTER} --require coffee-script/register test/models/*.coffee", (err, output) ->
      throw err if err
      console.log output

task 'setup', 'setup', ->
  launch 'rm', ['-f', 'mp_pipe']
  launch 'mkfifo', ['mp_pipe']

launch = (cmd, options=[], callback) ->
  app = spawn cmd, options
  app.stdout.pipe(process.stdout)
  app.stderr.pipe(process.stderr)
  app.on 'exit', (status) ->
    if status is 0
      callback?()
    else
      process.exit(status);