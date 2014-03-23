<div class="content">
    <h2>
        {{#if message}}
            {{{ message }}}
        {{else}}
            Loading...
        {{/if}}
    </h2>

    {{#if submessage}}
        {{{ submessage }}}
    {{/if}}
    <p>
        <img src='images/ajax-loader.gif' />
    </p>
</div>
