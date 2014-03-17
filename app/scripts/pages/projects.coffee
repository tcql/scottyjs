class window.ProjectsPage
    constructor: (sammy)->
        self = @

        sammy.get '#/projects', (context)->
            self.routeIndex(context, @)

        sammy.get '#/projects/add', (context)->
            self.routeAdd(context, @)

        sammy.post '#/projects/create', (context)->
            self.routeCreate(context, @)

        sammy.get '#/projects/delete/:name', (context)->
            self.routeDelete(context, @)


    routeIndex: (context, route)->
        projects = scotty.projects.projects.map (elem)->
            return elem.getMetadata()

        route.projects = projects.getCollection()
        route.partial('templates/projects/main.hb')


    routeAdd: (context, route)->
        $("#main").off('click').on 'click', '.file-upload-button', ()->
            $("#file_upload").trigger('click')

        $("#main").off('change').on 'change', '#file_upload', ()->
            $("#path").val($(this).val())

        route.form = @_buildAddEditForm(route)

        route.partial('templates/projects/add.hb')


    routeCreate: (context, route)->
        #console.log("creating")
        scotty.projects.createProject(route.params['project'])
        route.redirect("#/projects")


    routeDelete: (context, route)->
        console.log route.params["name"]
        scotty.projects.deleteProject(route.params["name"])



    _buildAddEditForm: (route)->
        versions = scotty.versions.installed.getCollection()
        form = new Sammy.FormBuilder('project', route.params.toHash())

        return {
            "name": form.text("name", {"class":"pure-input-1"})
            "path": form.text("path", {"class": "pure-input-1", "readonly":"", "id": "path"})
            "phaser_version": form.select("phaser_version", versions, {"class": "pure-input-1"})
        }
