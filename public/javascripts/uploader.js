function asyncSubmit(form, updates) {
    url = form.action + "?" + Hobo.ajaxUpdateParams(updates)
    YAHOO.util.Connect.setForm (form, true, true);
    var request = YAHOO.util.Connect.asyncRequest(
        'POST', url, {
            upload:function(response) {
                eval(response.responseXML.documentElement.textContent)
            }
        }
    );
    return false;
}

Event.addBehavior({
    
    'form.upload input[type=submit]:click': function(ev) {
        Event.stop(ev)
        asyncSubmit(this.up('form'), ['images'])
    }
    
})
 