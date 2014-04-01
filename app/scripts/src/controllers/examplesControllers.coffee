
controllers = angular.module 'examplesControllers', []

controllers.controller 'Examples.MainController', ['$scope', ($scope)->
    $scope.queued = false
    $scope.installed = scotty.examples.installed()

    $scope.download = ()->
        item = new ExamplesDownload

        $scope.queued = true
        $scope.installed = false
        window.queue.queueEvent item

        item.on 'end', ()=>
            $scope.queued = false
            $scope.installed = true

    $scope.view = ()->
        w = scotty.gui.spawn(
            "file://"+scotty.getExamplesDirectory()+"/examples/index.html",
            {
                "width":1300,
                "height":700,
                "toolbar":yes
            },
            false
        )
]
