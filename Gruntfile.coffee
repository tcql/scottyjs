module.exports = (grunt)->

    grunt.initConfig
        nodewebkit:
            options:
                version: '0.9.2',
                build_dir: '../webkitbuilds', # Where the build version of my node-webkit app is saved
                mac: false, # We want to build it for mac
                win: true, # We want to build it for win
                linux32: false, # We don't need linux32
                linux64: false # We don't need linux64
                zip: false, # Don't zip the app contents (Zipping slows down startup)
            src: ['./**/*'] # Your node-wekit app
        coffee:
            scotty:
                expand: true,
                flatten: false,
                cwd: 'app/scripts/src/',
                src: ['**/*.coffee','**/*.litcoffee'],
                dest: 'app/scripts/build',
                ext: '.js'
        pkg: grunt.file.readJSON('package.json'),
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

            clean:
                build:
                    src: ['build']




    grunt.loadNpmTasks('grunt-node-webkit-builder')
    grunt.loadNpmTasks('grunt-contrib-uglify')
    grunt.loadNpmTasks('grunt-contrib-coffee')
    grunt.loadNpmTasks('grunt-contrib-clean')

    grunt.registerTask 'scotty:build', ['coffee']# , 'uglify']
    grunt.registerTask 'deploy', ['scotty:build', 'uglify', 'nodewebkit']
