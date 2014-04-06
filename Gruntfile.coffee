module.exports = (grunt) ->
  # task
  grunt.initConfig
    dir: 
      src: "src"
      dest: "dist"
      jade: "jade"
      coffee: "coffee"
      js: "js"
    pkg: grunt.file.readJSON "package.json"

    bower:
      install: 
        options:
          targetDir: "<%= dir.dest %>/lib"
          layout: "byType"
          install: true
          verbose: false
          cleanBowerDir: true

    jade:
      compile:
        options:
          pretty: true
        expand: true
        cwd: '<%= dir.src %>/<%= dir.jade %>' 
        src: '**/*.jade'
        dest: '<%= dir.dest %>/'
        ext: '.html'

    coffee:
      compile:
        expand: true
        cwd: '<%= dir.src %>/<%= dir.coffee %>'
        src: '**/*.coffee'
        dest: '<%= dir.dist %>/<%= dir.js %>'
        ext: '.js'

    watch:
      jade:
        files: '<%= dir.src %>/**/*.jade'
        tasks: 'jade:compile'
      coffee:
        files: '<%= dir.src %>/**/*.coffee',
        tasks: 'coffee:compile'
      bower:
        files: 'bower.json',
        tasks: 'bower:install'

    # web server setting
    connect:
      site:
        options:
          hostname: "localhost"
          port: 8000
          base: "<%= dir.dest %>"


  grunt.loadNpmTasks "grunt-bower-task"
  grunt.loadNpmTasks "grunt-contrib-jade"
  grunt.loadNpmTasks "grunt-contrib-coffee"
  grunt.loadNpmTasks "grunt-contrib-watch"
  grunt.loadNpmTasks "grunt-contrib-connect"

  grunt.registerTask 'default', ['connect','watch']