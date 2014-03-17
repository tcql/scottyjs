
<div class="content">
    <h1>Projects</h1>
    <p>
        <a href="#/projects/add" class='button-success pure-button'>
            <i class='fa fa-plus'> </i> Add Project
        </a>
    </p>

    <table class='pure-table'>
        <thead>
            <tr>
                <th>Name</th>
                <th>Phaser Version</th>
                <th>Edit</th>
                <th>Delete</th>
            </tr>
        </thead>
        <tbody>
            {{#each projects}}
                <tr>
                    <td>{{this.name}}</td>
                    <td>{{this.phaser_version}}</td>
                    <td>
                        <a href="#/projects/edit/{{this.name}}" class='button-secondary pure-button'>
                            <i class='fa fa-pencil'> </i>
                        </a>
                    </td>
                    <td>
                        <a href="#/projects/delete/{{this.name}}" class='button-error pure-button'>
                            <i class='fa fa-trash-o'> </i>
                        </a>
                    </td>
                </tr>
            {{/each}}
        </tbody>
    </table>

</div>
