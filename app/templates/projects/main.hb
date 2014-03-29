<div class="header small-header">
    <img src="images/scotty-small.png" />
    <h1 class='pull-right'>Projects</h1>
</div>

<div class="scroll-container small-header">
    <div class="content">
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
                    <th>Play</th>
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
                            <a href="#/projects/play/{{this._id}}" class='button-success pure-button'>
                                <i class='fa fa-play-circle'> </i>
                            </a>
                        </td>
                        <td>
                            <a href="#/projects/edit/{{this._id}}" class='button-secondary pure-button'>
                                <i class='fa fa-pencil'> </i>
                            </a>
                        </td>
                        <td>
                            <a href="#/projects/delete/{{this._id}}" class='button-error pure-button'>
                                <i class='fa fa-trash-o'> </i>
                            </a>
                        </td>
                    </tr>
                {{/each}}
            </tbody>
        </table>

    </div>
</div>