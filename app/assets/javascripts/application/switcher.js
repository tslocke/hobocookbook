jQuery(document).ready(function($) {
    $("#version-switcher").val("1.4").on("change", function() {
        if($(this).val() == "1.0") {
            window.location = "http://cookbook-1.0.hobocentral.net"+window.location.pathname;
        } else if($(this).val() == "1.3") {
            window.location = "http://cookbook-1.3.hobocentral.net"+window.location.pathname;
        }
    })
});
