$(function () {

  'use strict';

  _.templateSettings = {
    interpolate: /\{\{\=(.+?)\}\}/g,
    evaluate: /\{\{(.+?)\}\}/g
  };

  $(document).foundation();

  var editor = document.getElementById("editor");
  var myCodeMirror = CodeMirror(editor, {
    mode:  "ruby",
    theme: "hopscotch",
    lineNumbers: true,
    styleActiveLine: true,
    matchBrackets: true
  });

  var maestroValidateUrl = $("#maestro-info").data("maestro-url");

  myCodeMirror.on("changes", function(doc, _){
    var sourceCode = doc.getValue();
    ragios.validateMaestro(maestroValidateUrl, sourceCode, ProcessMonitor.maestroSyntaxCheckResponse, ProcessMonitor.maestroError);
  });

  var httpCheck = false;
  var $form = $("#new_ragios_monitor");
  var syntaxErrorTemplate = _.template( $('#syntax-error-template').html() );
  var resultsTemplate = _.template( $('#results-template').html() );
  var $console = $("#console");
  var $url = $("#url");
  var maestroTestUrl = $("#test-monitor").data("maestro-test-url");
  var $sourceCode = $("#source-code");

  var ProcessMonitor = {
    init: function() {
      $("#http_check").on("change", this.showHttpCheck);
      $("#real_browser_monitor").on("change", this.showRealBrowserMonitor);
      $("#submit-monitor").on("click", this.submitMonitor);
      $("#test-monitor").on("click", this.testRealBrowserMonitor);
    },
    showHttpCheck: function() {
      httpCheck = true;
      $("#validations").hide("slow");
      $("#test-monitor").hide();
    },
    showRealBrowserMonitor: function() {
      httpCheck = false;
      $("#validations").show("slow");
      $("#test-monitor").show();
    },
    testRealBrowserMonitor: function() {
      var url = $url.val();
      var sourceCode = myCodeMirror.getValue();
      if (url.length > 0) {
        ragios.testMaestro(maestroTestUrl, url, sourceCode, ProcessMonitor.testMonitorResponse, ProcessMonitor.maestroError)
      } else {
        $console.html("<div class=\"search-results\">Fill in URL field before running a test.</div>");
      }
    },
    submitMonitor: function(e) {
      e.preventDefault();
      if(httpCheck) {
        $form.submit();
      } else {
        var sourceCode = myCodeMirror.getValue();

        $sourceCode.val(sourceCode);
        $form.submit();
      }
    },
    testMonitorResponse: function(result) {
      $console.html(
        resultsTemplate(result)
      )
    },
    maestroSyntaxCheckResponse: function(response) {
      if (response.error) {
        $console.html(
          syntaxErrorTemplate(response)
        )
        $(".monitor-actions").addClass("disabled");
      } else {
        $console.html("");
        $(".monitor-actions").removeClass("disabled");
      }
    },
    maestroError: function(xhr) {
      var response = $.parseJSON(xhr.responseText);
      ProcessMonitor.message.append(
        ProcessMonitor.messageTemplate({message: "Error", alert: "alert", response: JSON.stringify(response)})
      );
      $(document).foundation('alert', 'reflow');
    }
  }

  ProcessMonitor.init();
});
