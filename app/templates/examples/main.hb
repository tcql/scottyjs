<div class="header small-header">
    <img src="images/scotty-small.png" />
    <h1 class='pull-right'>Examples</h1>
</div>

<div class="scroll-container small-header">
    <div class="content">
        <p>scotty lets you download and view the phaser examples.</p>

        {{#if installed}}
        <p>
            You currently have phaser examples installed. You may update to the most recent version of the
            phaser examples at any time.
        </p>
        {{/if}}


        <p>
            {{#if queued}}
                <a class='button-secondary pure-button pure-button-disabled'>
                    <i class='fa fa-refresh fa-spin'> </i> In Progress
                </a>
            {{else}}
                {{#if installed}}
                    <a href="#/examples/install" class='button-secondary pure-button'>
                        <i class='fa fa-refresh'> </i> Update Examples
                    </a>
                    <a href="#/examples/open" class='button-success pure-button'>
                        <i class='fa fa-external-link'> </i> View Examples
                    </a>
                {{else}}
                    <a href="#/examples/install" class='button-secondary pure-button'>
                        <i class='fa fa-download'> </i> Install Examples
                    </a>
                {{/if}}
            {{/if}}
        </p>
    </div>
</div>
