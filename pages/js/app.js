$(function () {
    var app = $.sammy("#main", function () {
        this.use('Handlebars', 'hb');

        this.get('#/', function(context) {
            this.partial('templates/home.hb');
        });

        this.get('#/versions', function(context) {

            this.installed = []
            this.available = [
                {name:'2.0', installed: true},
                {name:'2.1', installed: this.params['installed']}
            ]
            this.partial('templates/versions/main.hb');
        });

        this.get('#/projects', function(context) {
            this.partial('templates/projects/main.hb');
        });

        this.get('#/versions/download/:version', function(context) {
            console.log(this.params['version'])
        });

    });

    app.run('#/');

});
