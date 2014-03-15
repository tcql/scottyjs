$(function () {
    var app = $.sammy("#main", function () {
        this.use('Handlebars', 'hb');

        this.get('#/', function(context) {
            this.partial('templates/home.hb');
        });

        this.get('#/versions', function(context) {

            this.installed = ['1.1.6']
            this.available = [
                {name:'1.1.6', installed: true},
                {name:'1.1.5', installed: this.params['installed']},
                {name:'1.1.4', installed: this.params['installed']}
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
