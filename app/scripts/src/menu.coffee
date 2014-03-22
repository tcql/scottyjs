$ ->
    $("#menu a").click ()->
        if $(this).hasClass "open-external"
            return

        $("#menu .active-link").removeClass("active-link")
        $(this).addClass "active-link"
