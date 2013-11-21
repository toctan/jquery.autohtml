module.exports = (grunt) ->

  grunt.initConfig
    pkg: grunt.file.readJSON 'package.json'
    coffee:
      compile:
        files:
          'lib/<%= pkg.name %>.js': 'src/<%= pkg.name %>.coffee'
    uglify:
      build:
        src:  'lib/<%= pkg.name %>.js'
        dest: 'lib/<%= pkg.name %>.min.js'

  grunt.loadNpmTasks 'grunt-contrib-uglify'
  grunt.loadNpmTasks 'grunt-contrib-coffee'

  grunt.registerTask 'default', ['coffee', 'uglify']
