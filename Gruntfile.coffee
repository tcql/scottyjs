module.exports = (grunt)->

    grunt.initConfig
        nodewebkit: {
            options: {
                version: '0.9.1',
                build_dir: './webkitbuilds', # Where the build version of my node-webkit app is saved
                mac: false, # We want to build it for mac
                win: true, # We want to build it for win
                linux32: false, # We don't need linux32
                linux64: false # We don't need linux64
                zip: true
            },
            src: ['./**/*'] # Your node-wekit app
        }


    grunt.loadNpmTasks('grunt-node-webkit-builder')
