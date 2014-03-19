window.scotty_lib = require("scotty-lib")
window.scotty = scotty.initialize()

connect = require('connect');

console.log window.location
# connect.createServer(
#     connect.static(scotty.getExamplesDirectory())
# ).listen(8081);


$ ->

    window.app = $.sammy "#main", ->
        @use('Handlebars', 'hb')
        @use('FormBuilder')
        @use('NestedParams')

        Handlebars.registerHelper 'call', (context, options)->
            console.log context

        @get '#/', (context)->
            @partial('templates/home.hb')


        @get '#/examples', (context)->
            w = window.open(
                "file://"+scotty.getExamplesDirectory()+"/examples/index.html",
                "_blank",
                "width=1300,height=700,toolbar=yes"
            )
            $(w).load ()->
                console.log $(w.document.body).html()
                console.log "hiii"
                $(w.document.body).append("<script type='text/javascript' src='file:///home/tcql/Documents/scotty/scotty-gui/app/vendor/coffee-script/coffee-script.js'></script>")
                $(w.document.body).append("<script type='text/coffeescript' src='file:///home/tcql/Documents/scotty/scotty-gui/app/scripts/devtools.coffee'></script>")


            @redirect("#/")

        window.vPage = new VersionsPage(@)
        window.pPage = new ProjectsPage(@)




    window.app.run('#/')

