
controllers = angular.module 'versionsControllers', []


controllers.controller 'Versions.MainController', ['$scope', ($scope)->
    $scope.loadVersions = ()->
        $scope.refreshing = false
        scotty.versions.versions.getAll (err, versions)=>
            $scope.available = versions
            $scope.$apply()

    $scope.loadVersions()

    $scope.refresh = ()->
        $scope.refreshing = true
        scotty.versions.fetch (versions)=>
            $scope.loadVersions()

    $scope.download = (version)->
        version.in_progress = true

        download = new VersionDownload(version.name)
        window.queue.queueEvent download

        download.on 'end', (item)->
            version.in_progress = false
            version.installed = true
            $scope.$apply()

]

