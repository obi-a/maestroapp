$(function () {

  'use strict';

  _.templateSettings = {
    interpolate: /\{\{\=(.+?)\}\}/g,
    evaluate: /\{\{(.+?)\}\}/g
  };

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
  var $form = $("#new_guest_monitor");
  var $sourceCode = $("#source-code");

  var $url = $("#url");
  var $console = $("#console");
  var syntaxErrorTemplate = _.template( $('#syntax-error-template').html() );
  var resultsTemplate = _.template( $('#results-template').html() );
  var maestroTestUrl = $("#maestro-info").data("maestro-test-url");
  var maestroValidateUrl = $("#maestro-info").data("maestro-url");



  var ProcessMonitor = {
    init: function() {
      $("#submit-monitor").on("click", this.submitMonitor);
      $("#test-monitor").on("click", Maestro.test);
    },
    submitMonitor: function(e) {
      e.preventDefault();
      var sourceCode = myCodeMirror.getValue();
      $sourceCode.val(sourceCode);
      $form.submit();
    }
  }


  Maestro.init($url, myCodeMirror, maestroValidateUrl, maestroTestUrl, $console, syntaxErrorTemplate, resultsTemplate);
  ProcessMonitor.init();
});
