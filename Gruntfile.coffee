fs = require 'fs-extra'

module.exports = (grunt)->
    nw_version = '0.9.2'

    grunt.initConfig
        pkg: grunt.file.readJSON('package.json')
        watch:
            coffee:
                files: ['app/scripts/src/**/*.coffee', 'app/scripts/src/**/*.litcoffee'],
                tasks: 'scotty:build'
        clean:
            build:
                options:
                    force: true
                src: ['build/app']
            webkitbuilds:
                options:
                    fore: true
                src: ['build/webkitbuilds']
        compress:
            win:
                options:
                    archive: "build/releases/scotty-<%= pkg.version %>-win.zip"
                files: [
                    {
                        cwd: 'build/webkitbuilds/releases/scotty-gui/win/'
                        expand: true
                        src: ['**']
                    }
                ]
            mac:
                options:
                    archive: "build/releases/scotty-<%= pkg.version %>-mac.zip"
                files: [
                    {
                        cwd: 'build/webkitbuilds/releases/scotty-gui/mac/'
                        expand: true
                        src: ['**']
                    }
                ]
            lin32:
                options:
                    archive: "build/releases/scotty-<%= pkg.version %>-linux32.zip"
                files: [
                    {
                        cwd: 'build/webkitbuilds/releases/scotty-gui/linux32/'
                        expand: true
                        src: ['**']
                    }
                ]
            lin64:
                options:
                    archive: "build/releases/scotty-<%= pkg.version %>-linux64.zip"
                files: [
                    {
                        cwd: 'build/webkitbuilds/releases/scotty-gui/linux64/'
                        expand: true
                        src: ['**']
                    }
                ]
        copy:
            build:
                cwd: '.'
                src: [
                    'app/css/**/*',
                    'app/scripts/build/**/*',
                    'app/templates/**/*',
                    'app/images/**/*',
                    'app/vendor/**/*',
                    'app/**/*.html',
                    'package.json',
                ]
                dest: 'build/app',
                expand: true
            win_build:
                cwd: 'build/app'
                src: '**'
                dest: './build/webkitbuilds/releases/scotty-gui/win/scotty-gui/'
                expand:true
            win_build_exe:
                src: 'build/webkitbuilds/cache/win/'+nw_version+'/nw.exe'
                dest: './build/webkitbuilds/releases/scotty-gui/win/scotty-gui/scotty-gui.exe'
                flatten: true
        exec:
            build: 'cd build/app; npm install --production'
        nodewebkit:
            options:
                version: nw_version
                build_dir: 'build/webkitbuilds', # Where the build version of my node-webkit app is saved
                mac: true, # We want to build it for mac
                win: true, # We want to build it for win
                linux32: true, # We don't need linux32
                linux64: true # We don't need linux64
                zip: true,
                keep_nw: true,
            src: ['./build/app/**/*'] # Your node-wekit app
        coffee:
            scotty:
                expand: true,
                flatten: false,
                cwd: 'app/scripts/src/',
                src: ['**/*.coffee','**/*.litcoffee'],
                dest: 'app/scripts/build',
                ext: '.js'
        uglify:
            options:
                compress:
                    drop_console: true
            scotty:
                options:
                    mangle: false
                    banner: '/*! <%= pkg.name %> - v<%= pkg.version %> - ' +
                        '<%= grunt.template.today("yyyy-mm-dd") %> */\n'
                files: [{
                    expand: true,
                    cwd: 'app/scripts/build/',
                    src: '**/*.js',
                    dest: 'app/scripts/build/'
                }]





    grunt.loadNpmTasks 'grunt-node-webkit-builder'
    grunt.loadNpmTasks 'grunt-contrib-uglify'
    grunt.loadNpmTasks 'grunt-contrib-coffee'
    grunt.loadNpmTasks 'grunt-contrib-clean'
    grunt.loadNpmTasks 'grunt-contrib-copy'
    grunt.loadNpmTasks 'grunt-exec'
    grunt.loadNpmTasks 'grunt-contrib-watch'
    grunt.loadNpmTasks 'grunt-contrib-compress'

    grunt.registerTask 'scotty:build', ['coffee']# , 'uglify']


    grunt.registerTask 'deploy', 'Builds distributables for scotty', ()->
        grunt.task.run [
            'clean:build',
            'copy:build',
            'exec',
            'nodewebkit',
            'copy:win_build',
            'copy:win_build_exe',
            'compress:win',
            'compress:mac',
            'compress:lin64',
            'compress:lin32'
        ]


