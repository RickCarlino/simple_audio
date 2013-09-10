{spawn, exec} = require 'child_process'

task 'dev', 'continually build', ->
    coffee = spawn 'coffee', ['-m', '-cw', '-o', '.', '.']
    coffee.stdout.on 'data', (data) -> console.log data.toString().trim()
    static_here = spawn 'static-here'
    static_here.stdout.on 'data', (data) -> console.log data.toString().trim()