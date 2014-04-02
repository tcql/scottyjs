(function() {
  var controllers;

  controllers = angular.module('projectsControllers', []);


  /*
   * MainController
   *
   * Handles listing projects, allowing add/edit/delete/play
   */

  controllers.controller('Projects.MainController', [
    '$scope', function($scope) {
      $scope.refresh = function() {
        return scotty.projects.projects.getAll((function(_this) {
          return function(err, projects) {
            $scope.projects = projects;
            return $scope.$apply();
          };
        })(this));
      };
      $scope.refresh();
      $scope.play = function(project) {
        return scotty.gui.spawn("file://" + project.path + "/index.html", {
          "width": 1300,
          "height": 700,
          "toolbar": "yes"
        });
      };
      return $scope["delete"] = function(project) {
        return scotty.projects["delete"](project._id, function(err, del) {
          return $scope.refresh();
        });
      };
    }
  ]);


  /*
   * AddEditController
   *
   * handles the ability to add and edit projects
   */

  controllers.controller('Projects.AddEditController', [
    '$scope', '$routeParams', function($scope, $routeParams) {
      $scope.project = {};
      if ($routeParams.id != null) {
        $scope.editing = true;
        scotty.projects.projects.getById($routeParams.id, function(err, project) {
          console.log(project);
          $scope.project = project;
          return $scope.$apply();
        });
      } else {
        $scope.editing = false;
      }
      scotty.versions.versions.getInstalled((function(_this) {
        return function(err, versions) {
          $scope.available_versions = versions;
          return $scope.$apply();
        };
      })(this));
      return $scope.browse = function() {
        $("#file_upload").trigger('click');
        $("#file_upload").one("change", function() {
          $scope.project.path = $(this).val();
          return $scope.$apply();
        });
      };
    }
  ]);

}).call(this);
