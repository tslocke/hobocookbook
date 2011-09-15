

Event.addBehavior({
    "#version-switcher:change": function(ev) {
        if(this.value == "1.0") {
            window.location = "http://cookbook-1.0.hobocentral.net"+window.location.pathname;
        }
    }
});

Event.observe(window, 'load', function() {
    $("version-switcher").value="1.3";
});

