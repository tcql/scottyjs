<div class="header small-header">
    <img src="images/scotty-small.png" />
    <h1 class='pull-right'>
        Phaser Versions
    </h1>
</div>

<div class="scroll-container small-header">
    <div class="content">
        <p>
            <a href="#/versions/refresh" class='button-secondary pure-button'>
                <i class='fa fa-refresh'> </i> Refresh List
            </a>
        </p>

        <table class='pure-table'>
            <tbody>
                {{#each available}}
                    <tr>
                        <td>{{this.name}}</td>
                        <td class='pure-g'>
                            {{#if this.installed}}
                                <a class='pure-u-1 button-success pure-button pure-button-disabled'>
                                    <i class='fa fa-check'> </i> Installed
                                </a>
                            {{else}}
                                {{#if this.in_progress}}
                                    <a class='pure-u-1 button-secondary pure-button pure-button-disabled'>
                                        <i class='fa fa-refresh fa-spin'> </i> In Progress
                                    </a>
                                {{else}}
                                    <a class='pure-u-1 button-success pure-button' href='#/versions/download/{{this.name}}'>
                                        <i class='fa fa-download'> </i> Download
                                    </a>
                                {{/if}}
                            {{/if}}
                        </td>
                    </tr>
                {{/each}}
            </tbody>
        </table>
    </div>
</div>
