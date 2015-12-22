module.exports = (grunt)->

  corsMiddleware = (req, res, next) ->
    console.log 'cors'
    res.setHeader 'Access-Control-Allow-Origin', '*'
    res.setHeader 'Access-Control-Allow-Methods', '*'
    res.setHeader 'Access-Control-Allow-Headers', 'Content-Type'
    next()

  require('load-grunt-tasks') grunt

  grunt.initConfig
    browserify:
      dist:
        files:
          'build/main.js': 'src/main.coffee'
          'build/spec/jasmine_spec.js': 'spec/jasmine_spec.coffee'
          'build/spec/inputPad_spec.js': 'spec/inputPad_spec.coffee'
        options:
          transform: ['coffeeify']

    uglify:
      dist:
        files: 'build/main.min.js': 'build/main.js'

    livereload:
      options:
        open: true,
        middleware: [corsMiddleware]

    watch:
      coffee:
        files: [
          'src/**/*.coffee',
          'src/**/*.js',
          'assets/**/*.css',
          'assets/**/*.png'
        ]
        tasks: ['build']
        options:
          livereload: 1337

    connect:
      server:
        options:
          open: yes
          port: 9001

    jasmine:
      all: 'build/spec/**/*spec.js'
      options:
        keepRunner: true
        vendor: 'node_modules/jasmine-ajax/lib/mock-ajax.js'
        helpers :
          'spec/helpers/ajax_responses.js'

    clean:
      dist:
        files: 'build'

  grunt.loadNpmTasks 'grunt-contrib-jasmine'
  grunt.registerTask 'build', ['clean', 'browserify', 'uglify']
  grunt.registerTask 'test', ['build', 'jasmine']
  grunt.registerTask 'default', ['build', 'connect', 'watch']

