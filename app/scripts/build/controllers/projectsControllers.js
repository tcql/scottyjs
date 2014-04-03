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
      return $scope.browse = function(project) {
        console.log(project.path);
        return nwgui.Shell.openItem(project.path);
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
      $scope.saving = false;
      if ($routeParams.id != null) {
        $scope.editing = true;
        scotty.projects.projects.getById($routeParams.id, function(err, project) {
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
      $scope.browse = function() {
        $("#file_upload").trigger('click');
        $("#file_upload").one("change", function() {
          $scope.project.path = $(this).val();
          return $scope.$apply();
        });
      };
      return $scope.save = function() {
        $scope.saving = true;
        if ($scope.project._id != null) {
          return scotty.projects.update($scope.project._id, $scope.project, (function(_this) {
            return function(err, num, doc) {
              return window.location.assign("#/projects");
            };
          })(this));
        } else {
          return scotty.projects.create($scope.project, {}, function() {
            return window.location.assign("#/projects");
          });
        }
      };
    }
  ]);

  controllers.controller('Projects.DeleteController', [
    '$scope', '$routeParams', function($scope, $routeParams) {
      $scope.project = {};
      $scope.deleting = false;
      scotty.projects.projects.getById($routeParams.id, function(err, project) {
        $scope.project = project;
        return $scope.$apply();
      });
      return $scope["delete"] = function() {
        $scope.deleting = true;
        return scotty.projects["delete"]($routeParams.id, function(err, del) {
          return window.location.assign("#/projects");
        });
      };
    }
  ]);

}).call(this);
