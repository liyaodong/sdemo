module.exports = (grunt) ->

  grunt.initConfig

    pkg: grunt.file.readJSON 'package.json'

    # custom settings start
    paths:
      src: './src'
      output: './assets'
      css: '<%= paths.output %>/css'
      js: '<%= paths.output %>/js'
    # custom settings end

    sass:
      styles:
        options:
          style: 'expanded'
          bundleExec: true
          sourcemap: 'none'
        files:
          '<%= paths.css %>/*|ProjectName|*.css': '<%= paths.src %>/*|ProjectName|*.scss'

    coffee:
      src:
        options:
          bare: true
        files:
          '<%= paths.js %>/*|ProjectName|*.js': '<%= paths.src %>/*|ProjectName|*.coffee'

    watch:
      styles:
        files: ['src/*.scss']
        tasks: ['sass']
        options:
          livereload: true
      src:
        files: ['src/*.coffee']
        tasks: ['coffee:src']
        options:
          livereload: true
      statics:
        files: ['**/*.html', '**/*.jpg', '**/*.png']
        options:
          livereload: true

  grunt.loadNpmTasks 'grunt-contrib-sass'
  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-contrib-watch'

  grunt.registerTask 'default', ['sass', 'coffee', 'watch']
