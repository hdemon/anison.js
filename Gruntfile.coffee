"use strict"
module.exports = (grunt) ->
  grunt.initConfig
    watch:
      test:
        files: [
          "<%= coffee.lib.src %>"
          "<%= simplemocha.all.src %>"
        ]
        tasks: ["test"]

    simplemocha:
      all:
        src: ['test/**/*.coffee']
        options:
          timeout: 3000
          ignoreLeaks: false
          ui: 'bdd'
          compilers: 'coffee:coffee-script'


  # These plugins provide necessary tasks.
  grunt.loadNpmTasks "grunt-contrib-coffee"
  grunt.loadNpmTasks "grunt-contrib-watch"
  grunt.loadNpmTasks "grunt-simple-mocha"

  grunt.registerTask "default", ["watch"]
  grunt.registerTask "test", ["simplemocha"]
