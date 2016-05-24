var ragios = {
  request : function(options) {
      $.ajax(options);
    },

    start : function(url, success, error) {
      this.request({
        type: "PUT",
        url: url,
        success: success,
        error: error
      });
    },

    stop : function(url, success, error) {
      this.request({
        type: "PUT",
        url: url,
        success: success,
        error: error
      });
    },

    test : function(url, success, error) {
      this.request({
        type: "POST",
        url: url,
        success: success,
        error: error
      });
    },

    create : function(data, success, error) {
        this.request({
            type: "POST",
            url: "/monitors/",
            success: success,
             error: error,
             data: data
        });
    },

    delete : function(url, success, error) {
      this.request({
        type: "DELETE",
        url: url,
        success: success,
        error: error
      });
    },

    delete_event : function(event_id, success, error) {
        this.request({
            type: "DELETE",
            url: "/events/" + event_id,
            success: success,
            error: error
        });
    },

    update : function (monitor_id, data, success, error) {
        this.request({
            type: "PUT",
            url: "/monitors/" + monitor_id,
            success: success,
            error: error,
            data: data,
            contentType: "application/json"
        });
    },

    find : function(url, success, error) {
      this.request({
        type: "GET",
        url: url,
        success: success,
        error: error
      });
    },

    find_event : function(event_id, success, error) {
        this.request({
            type: "GET",
            url: "/events/" + event_id,
            success: success,
            error: error,
        });
    },

    getNotifications : function(monitor_id, startDate, endDate, success, error) {
        this.request({
            type: "GET",
            url: "/monitors/" + monitor_id + "/events_by_type/monitor.notification",
            data: {start_date: startDate, end_date: endDate },
            success: success,
            error: error
        });
    },

    getEvents : function(url, success, error) {
      this.request({
        type: "GET",
        url: url,
        success: success,
        error: error
      });
    },

    getResultsByState : function( monitor_id, state, startDate, endDate, success, error) {
        this.request({
            type: "GET",
            url: "/monitors/" + monitor_id + "/events_by_state/" + state,
            data: {start_date: startDate, end_date: endDate },
            success: success,
            error: error
        });
    },

    getMonitors : function(success, error) {
        this.request({
            type: "GET",
            url: "/monitors",
            success: success,
            error: error
        });
    }

};

