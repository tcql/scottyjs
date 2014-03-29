<div class="header small-header">
    <img src="images/scotty-small.png" />

    <h1 class='pull-right'>
        {{#if editing}}
            Edit Project
        {{else}}
            Add Project
        {{/if}}
    </h1>
</div>

<div class="scroll-container small-header">
    <div class="content">

        <form class="pure-form pure-form-stacked project-add-form" method="POST" action="#/projects/create">
            <fieldset>
                <div class='pure-g'>
                    <div class='pure-u-1-2'>

                        <div class='pure-u-1'>
                            <label for="name">Project Name</label>
                            {{{ form.name }}}

                        </div>


                        <div class='pure-u-1'>
                            <label for="phaser_version">Phaser Version</label>
                            {{{ form.phaser_version }}}
                        </div>

                        <div class='pure-u-1'>
                            <label for="path">Project Path</label>
                        </div>

                        <div class='pure-u-1'>
                            <div class='pure-u-16-24'>
                                {{{ form.path }}}
                            </div>
                            <div class='pure-u-7-24'>
                                <a class="file-upload-button input-button pure-button button-secondary">
                                    <i class="fa fa-folder-open"> </i> Select
                                </a>
                            </div>
                        </div>
                    </div>
                </div>

                {{{ form.id }}}
                <input style='display:none;' id='file_upload' type="file" nwdirectory />

                <input type="submit" class="pure-button button-success" value="Create" />
            </fieldset>
        </form>
    </div>
</div>
