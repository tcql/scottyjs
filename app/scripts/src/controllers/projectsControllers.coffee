
controllers = angular.module 'projectsControllers', []


###
 * MainController
 *
 * Handles listing projects, allowing add/edit/delete/play
###
controllers.controller 'Projects.MainController', ['$scope', ($scope)->

    $scope.refresh = ()->
        scotty.projects.projects.getAll (err, projects)=>
            $scope.projects = projects
            $scope.$apply()

    $scope.refresh()

    $scope.play = (project)->
        scotty.gui.spawn(
            "file://"+project.path+"/index.html",
            {
                "width": 1300,
                "height": 700,
                "toolbar": "yes"
            }
        )

    $scope.delete = (project)->
        scotty.projects.delete project._id, (err, del)->
            $scope.refresh()

]


###
 * AddEditController
 *
 * handles the ability to add and edit projects
###
controllers.controller 'Projects.AddEditController', ['$scope', '$routeParams', ($scope, $routeParams)->
    $scope.project = {}
    $scope.saving = false

    if $routeParams.id?
        $scope.editing = true

        scotty.projects.projects.getById $routeParams.id, (err, project)->
            $scope.project = project
            $scope.$apply()
    else
        $scope.editing = false


    scotty.versions.versions.getInstalled (err, versions)=>
        $scope.available_versions = versions
        $scope.$apply()


    $scope.browse = ()->
        # todo: write custom angular directive to handle this.
        $("#file_upload").trigger('click')
        $("#file_upload").one "change", ()->
            $scope.project.path = $(this).val()
            $scope.$apply()

        return

    $scope.save = ()->
        $scope.saving = true

        if $scope.project._id?
            scotty.projects.update $scope.project._id, $scope.project, (err, num, doc)=>
                window.location.assign "#/projects"
        else
            scotty.projects.create $scope.project, {}, ()->
                window.location.assign "#/projects"


]
