<div class="content">
    <h1>Examples</h1>
    <p>scotty lets you download and view the phaser examples.</p>

    {{#if installed}}
    <p>
        You currently have phaser examples installed. You may update to the most recent version of the
        phaser examples at any time.
    </p>
    {{/if}}


    <p>
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
    </p>
</div>
