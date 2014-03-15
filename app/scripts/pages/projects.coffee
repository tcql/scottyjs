class window.ProjectsPage
    constructor: (sammy)->
        self = @

        sammy.get '#/projects', (context)->
            self.routeIndex(context, @)

    routeIndex: (context, route)->
        route.partial('templates/projects/main.hb')
