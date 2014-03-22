$ ->
    $("#menu a").click ()->
        $("#menu .active-link").removeClass("active-link")
        $(this).addClass "active-link"
