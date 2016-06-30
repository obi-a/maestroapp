$(function() {
  'use strict';

  _.templateSettings = {
    interpolate: /\{\{\=(.+?)\}\}/g,
    evaluate: /\{\{(.+?)\}\}/g
  };

  var uptimeMonitor = $("#monitor-info").data("is-uptime-monitor");

  if (uptimeMonitor) {
    var editor = document.getElementById("editor");
    var myCodeMirror = CodeMirror(editor, {
      mode:  "ruby",
      theme: "hopscotch",
      lineNumbers: true,
      styleActiveLine: true,
      matchBrackets: true
    });

    var $url;
    var $console = $("#console");
    var syntaxErrorTemplate = _.template( $('#syntax-error-template').html() );
    var resultsTemplate = _.template( $('#results-template').html() );
    var maestroTestUrl = $("#maestro-info").data("maestro-test-url");
    var maestroValidateUrl = $("#maestro-info").data("maestro-url");
  }


  var getMonitorId = _.memoize(function () {
    return $("#monitor-info").data("monitor-id");
  });
  var vent = _.extend({}, Backbone.Events);
  var eventsUrl = $("#monitor-info").data("events-url");
  var findMonitorUrl = $("#monitor-info").data("find-monitor-url");
  var testUrl = $("#monitor-info").data("test-url");
  var startUrl = $("#monitor-info").data("start-url");
  var stopUrl = $("#monitor-info").data("stop-url");
  var restfulUrl = $("#monitor-info").data("restful-url");
  var dashboardUrl = $("#monitor-info").data("dashboardUrl");
  var $allEventsTab = $("#all-events-tab");
  var $allEvents = $("#all-events");
  var $monitorsTab = $("#monitors-tab");
  var $monitor = $("#monitor");
  var $message = $("#message");

  var Util = {
    init: function () {
      this.message = $message;
      this.messageTemplate = _.template( $('#message-template').html() );
    },
    success: function (data) {
      Util.message.append(
        Util.messageTemplate({message: "Success", alert: "info", response: JSON.stringify(data)})
      );
      vent.trigger("data:refresh", "update-monitor");
      $(document).foundation('alert', 'reflow');
    },
    error: function ( xhr ) {
      var response = $.parseJSON(xhr.responseText);
      Util.message.append(
        Util.messageTemplate({message: "Error", alert: "alert", response: JSON.stringify(response)})
      );
      $(document).foundation('alert', 'reflow');
    }
  }

  var monitor = {
    init: function () {
      this.$el = $("#monitor-details");
      this.$form = $("#monitor-form");
      this.template = _.template( $('#monitor-details-template').html() );
      this.find();
    },
    createEditor: function () {

    },
    render: function (data) {
      monitor.$el.html(
        monitor.template(data)
      );
      if(uptimeMonitor) {
        myCodeMirror.setValue(data["exists?"])
        myCodeMirror.refresh();
        $url = $("#url");
        Maestro.init($url, myCodeMirror, maestroValidateUrl, maestroTestUrl, $console, syntaxErrorTemplate, resultsTemplate);
      }
    },
    update: function () {
      var data = {};
      monitor.$form.serializeArray().map(function(i){data[i.name] = i.value;});

      var alert_emails = [];

      $('input:checkbox').map(function() {
        if( this.checked ) {
          alert_emails.push(this.value)
        }
      });

      if(!_.isEmpty(alert_emails) ) {
        data.alert_emails = alert_emails
      }

      var attributesJson = JSON.stringify( data );
      ragios.update( restfulUrl, attributesJson, Util.success, Util.error );
    },
    find: function () {
      ragios.find( findMonitorUrl, this.render, Util.error );
    },
    start: function () {
      if( ragiosHelper.confirm("Are you sure you want to start this monitor?") ) {
        ragios.start( startUrl, Util.success, Util.error );
      }
    },
    stop: function () {
      if( ragiosHelper.confirm("Are you sure you want to stop this monitor?") ) {
        ragios.stop( stopUrl, Util.success, Util.error );
      }
    },
    test: function () {
      if( ragiosHelper.confirm("Are you sure you want to test this monitor?") ) {
        ragios.test( testUrl, Util.success, Util.error);
      }
    },
    delete: function () {
      if( ragiosHelper.confirm("Are you sure you want to delete this monitor?") ) {
        var deleteSuccess = function () {
          ragiosHelper.redirect_to(dashboardUrl);
        };
        ragios.delete( restfulUrl, deleteSuccess, Util.error );
      }
    }
  };

  var EventTable = {
    create: function(tableSelector) {
      return Object.create(this).init(tableSelector)
    },
    init: function(tableSelector) {
      this.tableSelector = $(tableSelector);
      return this;
    },
    buildTable: function () {
      this.reset(
        this.createTable
      );
    },
    refreshTable: function () {
      this.reset(
        this.redoTableEvt
      );
    },
    dataChanged: function () {
      this.reset(
        this.reloadTable
      );
    }
  }

  var allEvents = EventTable.create(
    '#all-events-datatable'
  );
  _.extend(allEvents, {
    reset: function(renderTable) {
      ragios.getEvents(
        eventsUrl,
        renderTable,
        Util.error
      );
    },
    createTable: function(data) {
      allEvents.table =
      allEvents.tableSelector.dataTable({
        "bFilter": false,
        "bStateSave": true,
        "order": [ 0, 'desc' ],
        "data": allEvents.cleanData(data),
        "columns": allEvents.columns(),
        "aLengthMenu": [[5, 10, 15, -1], [5, 10, 15, 20]],
        "iDisplayLength": 5
      });
    },
    reloadTable: function (data) {
      allEvents.table.fnClearTable();
      if(data.length > 0 ) { allEvents.table.fnAddData( allEvents.cleanData(data) ); }
    },
    redoTableEvt: function (data) {
      allEvents.reloadTable(data)
      vent.trigger("data:refresh", "all-events");
    },
    columns: function () {
      return [
        { "data": "time", "width": "10%" },
        { "data": "event_type", "width": "5%" },
        { "data": "state", "width": "5%" },
        { "data": "event", "width": "20%" }
      ]
    },
    cleanData: function (data) {
      return _.map(data, function(data) {
        return {
          time: ragiosHelper.formatDate(data.time),
          event_type: data.event_type,
          state: ragiosHelper.formatState(data.state),
          event: ragiosHelper.formatResults(data.event)
        };
      });
    }
  });

  vent.on("data:refresh", function(item){
    if(item === "update-monitor") {
      monitor.find();
    }
  });

  $("#all-events-link").on("click", function() {
    allEvents.dataChanged();
    Backbone.history.navigate('allevents');
  });

  $("#monitor-link").on("click", function() {
    monitor.find();
    Backbone.history.navigate('monitor');
  });

  var MonitorRouter = Backbone.Router.extend({
    routes: {
      "monitor" : "monitor",
      "allevents" : "allEvents"
    },
    monitor: function() {
      $allEventsTab.removeClass('active');
      $allEvents.removeClass('active');

      $monitorsTab.addClass('active');
      $monitor.addClass('active');
    },
    allEvents: function() {
      $monitorsTab.removeClass('active');
      $monitor.removeClass('active');

      $allEventsTab.addClass('active');
      $allEvents.addClass('active');
    }
  });


  $( "#start-button" ).on("click", function() { monitor.start(); });
  $( "#stop-button" ).on("click", function() { monitor.stop(); });
  $( "#test-button" ).on("click", function() { monitor.test(); });
  $( "#delete-button" ).on("click", function() { monitor.delete(); });
  $( "#update-monitor-button" ).on("click", function() { monitor.update(); });
  $("#test-monitor").on("click", Maestro.test);

  Util.init()
  monitor.init()
  allEvents.buildTable();

  var monitorRouter = new MonitorRouter();
  Backbone.history.start();
});
