(function() {
  window.ProjectsPage = (function() {
    function ProjectsPage(sammy) {
      var self;
      self = this;
      sammy.get('#/projects', function(context) {
        return self.routeIndex(context, this);
      });
      sammy.get('#/projects/add', function(context) {
        return self.routeAdd(context, this);
      });
      sammy.post('#/projects/create', function(context) {
        return self.routeCreate(context, this);
      });
      sammy.get('#/projects/delete/:id', function(context) {
        return self.routeDelete(context, this);
      });
      sammy.get('#/projects/edit/:id', function(context) {
        return self.routeEdit(context, this);
      });
      sammy.get('#/projects/play/:id', function(context) {
        return self.routePlay(context, this);
      });
    }

    ProjectsPage.prototype.routeIndex = function(context, route) {
      return scotty.projects.projects.getAll((function(_this) {
        return function(err, projects) {
          route.projects = projects;
          return route.partial('templates/projects/main.hb');
        };
      })(this));
    };

    ProjectsPage.prototype.routeAdd = function(context, route) {
      $("#main").off('click').on('click', '.file-upload-button', function() {
        return $("#file_upload").trigger('click');
      });
      $("#main").off('change').on('change', '#file_upload', function() {
        return $("#path").val($(this).val());
      });
      return this._buildAddEditForm(route.params.toHash(), (function(_this) {
        return function(form) {
          route.form = form;
          if (route.params['name']) {
            route.editing = true;
          } else {
            route.editing = false;
          }
          return route.partial('templates/projects/add.hb');
        };
      })(this));
    };

    ProjectsPage.prototype.routeCreate = function(context, route) {
      route.message = "Saving Project...";
      route.render('templates/loading.hb').swap().then((function(_this) {
        return function() {
          var id, project;
          project = route.params['project'];
          if (project['_id']) {
            id = project['_id'];
            return scotty.projects.update(id, project, function(err, num, doc) {
              return route.redirect("#/projects");
            });
          } else {
            return scotty.projects.create(project, {}, function() {
              return route.redirect("#/projects");
            });
          }
        };
      })(this));
      return false;
    };

    ProjectsPage.prototype.routeDelete = function(context, route) {
      return scotty.projects["delete"](route.params["id"], function(err, del) {
        if (!err) {
          return route.redirect("#/projects");
        }
      });
    };

    ProjectsPage.prototype.routeEdit = function(context, route) {
      return scotty.projects.projects.getById(route.params['id'], (function(_this) {
        return function(err, project) {
          return route.redirect("#/projects/add", project);
        };
      })(this));
    };

    ProjectsPage.prototype.routePlay = function(context, route) {
      return scotty.projects.projects.getById(route.params['id'], (function(_this) {
        return function(err, project) {
          scotty.gui.spawn("file://" + project.path + "/index.html", {
            "width": 1300,
            "height": 700,
            "toolbar": "yes"
          });
          return route.redirect("#/projects");
        };
      })(this));
    };

    ProjectsPage.prototype._buildAddEditForm = function(params, callback) {
      if (callback == null) {
        callback = function() {};
      }
      return scotty.versions.versions.getInstalled((function(_this) {
        return function(err, versions) {
          var form, i, output_versions, _i, _len;
          output_versions = [];
          for (_i = 0, _len = versions.length; _i < _len; _i++) {
            i = versions[_i];
            output_versions.push(i.name);
          }
          form = new Sammy.FormBuilder('project', params);
          return callback({
            "id": form.hidden("_id"),
            "name": form.text("name", {
              "class": "pure-input-1"
            }),
            "path": form.text("path", {
              "class": "pure-input-1",
              "readonly": "",
              "id": "path"
            }),
            "phaser_version": form.select("phaser_version", output_versions, {
              "class": "pure-input-1"
            })
          });
        };
      })(this));
    };

    return ProjectsPage;

  })();

}).call(this);
