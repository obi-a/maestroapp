$(function () {

  'use strict';

  _.templateSettings = {
    interpolate: /\{\{\=(.+?)\}\}/g,
    evaluate: /\{\{(.+?)\}\}/g
  };

  $(document).foundation();

  var maestroCode = $("#maestro-info").data("source-code");
  var code = !!maestroCode ? maestroCode : ""

  var editor = document.getElementById("editor");
  var myCodeMirror = CodeMirror(editor, {
    value: code,
    mode:  "ruby",
    theme: "hopscotch",
    lineNumbers: true,
    styleActiveLine: true,
    matchBrackets: true
  });

  var httpCheck = false;
  var $form = $("#new_ragios_monitor");
  var $sourceCode = $("#source-code");

  var $url = $("#url");
  var $console = $("#console");
  var syntaxErrorTemplate = _.template( $('#syntax-error-template').html() );
  var resultsTemplate = _.template( $('#results-template').html() );
  var maestroTestUrl = $("#maestro-info").data("maestro-test-url");
  var maestroValidateUrl = $("#maestro-info").data("maestro-url");
  var loadingTemplate = _.template( $("#simple-loader-template").html() );

  var ProcessMonitor = {
    init: function() {
      $("#http_check").on("change", this.showHttpCheck);
      $("#real_browser_monitor").on("change", this.showRealBrowserMonitor);
      $("#submit-monitor").on("click", this.submitMonitor);
      $("#test-monitor").on("click", Maestro.test);
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
    submitMonitor: function(e) {
      e.preventDefault();
      if(httpCheck) {
        $form.submit();
      } else {
        var sourceCode = myCodeMirror.getValue();
        $sourceCode.val(sourceCode);
        $form.submit();
      }
    }
  }

  Maestro.init($url, myCodeMirror, maestroValidateUrl, maestroTestUrl, $console, syntaxErrorTemplate, resultsTemplate, loadingTemplate);
  ProcessMonitor.init();
});
