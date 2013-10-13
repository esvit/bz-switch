path = require 'path'

# Build configurations.
module.exports = (grunt) ->
    grunt.initConfig
        cmpnt: grunt.file.readJSON('bower.json'),
        banner: '/*! ngTable v<%= cmpnt.version %> by Vitalii Savchuk(esvit666@gmail.com) - ' +
                    'https://github.com/esvit/bz-switch - New BSD License */\n',
            
        # Deletes built file and temp directories.
        clean:
            working:
                src: [
                    'bz-switch.*'
                    './.temp/views'
                    './.temp/'
                ]
        copy:
            styles:
                files: [
                    src: './src/styles/bz-switch.less'
                    dest: './bz-switch.less'
                ]

        uglify:
            # concat js files before minification
            js:
                src: ['bz-switch.src.js']
                dest: 'bz-switch.js'
                options:
                  banner: '<%= banner %>'
                  sourceMap: (fileName) ->
                    fileName.replace /\.js$/, '.map'
        concat:
            # concat js files before minification
            js:
                src: [
                    'src/scripts/*.js'
                ]
                dest: 'bz-switch.src.js'

        less:
            css:
                files:
                    'bz-switch.css': 'src/styles/bz-switch.less'

        cssmin:
            css:
                files:
                    'bz-switch.css': 'bz-switch.css'
                options:
                    banner: '<%= banner %>'

        ngTemplateCache:
            views:
                files:
                    './.temp/scripts/views.js': 'src/bz-switch/**/*.html'
                options:
                    trim: 'src/'
                    module: 'ngTable'

    # Register grunt tasks supplied by grunt-contrib-*.
    # Referenced in package.json.
    # https://github.com/gruntjs/grunt-contrib
    grunt.loadNpmTasks 'grunt-contrib-clean'
    grunt.loadNpmTasks 'grunt-contrib-copy'
    grunt.loadNpmTasks 'grunt-contrib-less'
    grunt.loadNpmTasks 'grunt-contrib-cssmin'
    grunt.loadNpmTasks 'grunt-contrib-uglify'
    grunt.loadNpmTasks 'grunt-contrib-concat'


    # Register grunt tasks supplied by grunt-hustler.
    # Referenced in package.json.
    # https://github.com/CaryLandholt/grunt-hustler
    grunt.loadNpmTasks 'grunt-hustler'

    grunt.registerTask 'dev', [
        'clean'
        #'ngTemplateCache'
        'concat'
        #'less'
        'copy'
    ]
    grunt.registerTask 'default', [
        'dev'
        'uglify'
        #'cssmin'
    ]
