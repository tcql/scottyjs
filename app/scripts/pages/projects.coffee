class window.ProjectsPage
    constructor: (sammy)->
        self = @

        sammy.get '#/projects', (context)->
            self.routeIndex(context, @)

        sammy.get '#/projects/add', (context)->
            self.routeAdd(context, @)

        sammy.post '#/projects/create', (context)->
            self.routeCreate(context, @)

        sammy.get '#/projects/delete/:id', (context)->
            self.routeDelete(context, @)


    routeIndex: (context, route)->
        scotty.projects.projects.getAll (err, projects)=>
            route.projects = projects
            route.partial('templates/projects/main.hb')


    routeAdd: (context, route)->
        $("#main").off('click').on 'click', '.file-upload-button', ()->
            $("#file_upload").trigger('click')

        $("#main").off('change').on 'change', '#file_upload', ()->
            $("#path").val($(this).val())

        @_buildAddEditForm route, (form)=>
            route.form = form
            route.partial('templates/projects/add.hb')


    routeCreate: (context, route)->
        scotty.projects.create route.params['project'], {}, ()=>
            route.redirect("#/projects")


    routeDelete: (context, route)->
        console.log route.params["id"]
        scotty.projects.delete route.params["id"], (err, del)->
            route.redirect("#/projects") if not err



    _buildAddEditForm: (route, callback = ->)->
        scotty.versions.versions.getInstalled (err, versions)=>
            output_versions = []

            for i in versions
                output_versions.push i.name



            form = new Sammy.FormBuilder('project', route.params.toHash())

            callback({
                "name": form.text("name", {"class":"pure-input-1"})
                "path": form.text("path", {"class": "pure-input-1", "readonly":"", "id": "path"})
                "phaser_version": form.select("phaser_version", output_versions, {"class": "pure-input-1"})
            })
