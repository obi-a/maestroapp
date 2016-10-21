var ragiosHelper = {

    confirm : function( message ) {
        message = message || "Are you sure you want to continue?";
        return confirm( message );
    },

    redirect_to: function( path ) {
        window.location.replace( path );
    },
    //TODO: cleanup later
    formatResults: function (result) {
        if( _.isUndefined(result["monitor status"]) ) {
            if(_.isUndefined(result.results)) {
                if(!_.isUndefined(result.notified)) {
                    if(result.notified === "resolved") {
                        return "Notified: <span class=\"label success\">Issue Resolved</span>";
                    } else if (result.notified === "failed") {
                        return "Notified: <span class=\"label alert\">Test Failed</span>";
                    }
                } else if( !_.isUndefined(result.url_monitor) ) {
                    if(result.url_monitor === "success") {
                        return "Status code: "+ result.result + " (OK)";
                    } else if (result.url_monitor === "failure") {
                        return result.result;
                    }
                } else if( !_.isUndefined(result.error) ) {
                    return result.error;
                } else {

                    try{
                        return _.reduce(_.pairs(result), function( memo, pair ) {
                            return memo.toString() + "\n" + pair;
                        });
                    } catch (e) { return ""; }
                }
            } else {
                var results = result.results;
                var count = 1;
                return _.reduce(results, function(memo, item) {
                    var res;
                    if (item[1] === "exists_as_expected") {
                        res = "[" + count + "] " + item[0] + " <span class=\"label success\">exists as expected</span>";
                    } else if (item[1] === "does_not_exist_as_expected") {
                        res = "[" + count + "] " + item[0] + " <span class=\"label alert\">does not exist as expected</span>";
                    }
                    count++;
                    return memo.toString() + "<br/>" + res;
                }, " ");
            }
        } else {
            return result["monitor status"]
        }
    },

    formatDate: function (date) {
        return moment(date).format('llll');
    },

    formatDateSmall: function (date) {
        return moment(date).format('L LT');
    },

    formatEventId: function (event_id) {
        return '<a href="/admin/events/' + event_id + '" data-toggle="modal" data-target="#event-modal">' + event_id + '</a>';
    },

    formatStatus: function (status) {
        if(status === "active") {
            return '<span class="label label-primary">active</span>'
        } else if(status === "stopped") {
            return '<span class="label label-warning">stopped</span>'
        }
    },

    formatEventType: function(event_type) {
        switch (event_type) {
            case "monitor.start":
                return "start";
            case "monitor.stop":
                return "stop";
            case "monitor.test":
                return "test";
            case "monitor.create":
                return "create";
            case "monitor.update":
                return "update";
            case "monitor.notification":
                return "notification";
        }
    },

    formatState: function (state) {
        if(state === "passed") {
            return '<span class="label success">passed</span>'
        } else if(state === "resolved") {
            return '<span class="label success">resolved</span>'
        } else if(state === "failed") {
            return '<span class="label alert">failed</span>'
        } else if (state === "error")  {
            return '<span class="label warning">error</span>'
        } else if (state === "stopped")  {
            return '<span class="label warning">stopped</span>'
        } else if (state === "started")  {
            return '<span class="label info">started</span>'
        } else {
            return '<span class="label info">' + state + '</span>'
        }
    },

    linkTo: function( text, uri) {
       var anchor =  _.template('<a href="<%= uri %>"><%= text %></a>');
       return anchor({uri: uri, text: text});
    }
};