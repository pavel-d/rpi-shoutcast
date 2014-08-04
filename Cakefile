# Cakefile
{exec} = require "child_process"

REPORTER = "spec"

task "test", "run tests", ->
  exec "NODE_ENV=test mocha -R #{REPORTER} --require coffee-script/register test/models/*.coffee", (err, output) ->
      throw err if err
      console.log output