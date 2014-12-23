module.exports = (grunt) ->

  grunt.initConfig

    pkg: grunt.file.readJSON 'package.json'

    # custom settings
    paths:
      src: './src'
      output: './assets'
      css: '<%= paths.output %>/css'
      js: '<%= paths.output %>/js'

    sass:
      styles:
        options:
          style: 'expanded'
          bundleExec: true
          sourcemap: 'none'
        files:
          '<%= paths.css %>/base.css': '<%= paths.src %>/base.scss'

    coffee:
      src:
        options:
          bare: true
        files:
          '<%= paths.js %>/main.js': '<%= paths.src %>/main.coffee'

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
