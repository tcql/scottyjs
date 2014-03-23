class window.ProjectsPage
    constructor: (sammy)->
        self = @

        sammy.get '#/projects', (context)->
            self.routeIndex(context, @)

        sammy.get '#/projects/add', (context)->
            self.routeAdd(context, @)

        sammy.post '#/projects/create', (context)->
            self.routeCreate(context, @)

        sammy.get '#/projects/create', (context)->
            console.log "blergh."

        sammy.get '#/projects/delete/:id', (context)->
            self.routeDelete(context, @)

        sammy.get '#/projects/edit/:id', (context)->
            self.routeEdit(context, @)

        sammy.get '#/projects/play/:id', (context)->
            self.routePlay(context, @)


    routeIndex: (context, route)->
        scotty.projects.projects.getAll (err, projects)=>
            route.projects = projects
            route.partial('templates/projects/main.hb')


    routeAdd: (context, route)->
        $("#main").off('click').on 'click', '.file-upload-button', ()->
            $("#file_upload").trigger('click')

        $("#main").off('change').on 'change', '#file_upload', ()->
            $("#path").val($(this).val())

        @_buildAddEditForm route.params.toHash(), (form)=>
            route.form = form
            if route.params['name']
                route.editing = true
            else
                route.editing = false
            route.partial('templates/projects/add.hb')


    routeCreate: (context, route)->

        console.log "saving"

        route.message = "Saving Project..."
        route.render('templates/loading.hb').swap().then ()=>
            project = route.params['project']
            if project['_id']
                id = project['_id']
                scotty.projects.update id, project, (err, num, doc)=>
                    route.redirect("#/projects")
            else
                scotty.projects.create project, {}, ()=>
                    route.redirect("#/projects")

        return false


    routeDelete: (context, route)->
        scotty.projects.delete route.params["id"], (err, del)->
            route.redirect("#/projects") if not err


    routeEdit: (context, route)->
        scotty.projects.projects.getById route.params['id'], (err, project)=>
            # Pass on the project as params
            route.redirect("#/projects/add", project)


    routePlay: (context, route)->
        scotty.projects.projects.getById route.params['id'], (err, project)=>
            scotty.gui.spawn(
                "file://"+project.path+"/index.html",
                {
                    "width": 1300,
                    "height": 700,
                    "toolbar": "yes"
                }
            )

            route.redirect("#/projects")


    _buildAddEditForm: (params, callback = ->)->
        scotty.versions.versions.getInstalled (err, versions)=>
            output_versions = []

            for i in versions
                output_versions.push i.name

            form = new Sammy.FormBuilder('project', params)

            callback({
                "id": form.hidden("_id")
                "name": form.text("name", {"class":"pure-input-1"})
                "path": form.text("path", {"class": "pure-input-1", "readonly":"", "id": "path"})
                "phaser_version": form.select("phaser_version", output_versions, {"class": "pure-input-1"})
            })
