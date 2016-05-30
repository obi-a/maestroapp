$(function () {
  $(document).foundation();

  var editor = document.getElementById("editor");
  var myCodeMirror = CodeMirror(editor, {
    value: "title.with_text(\"hello world\")\n",
    mode:  "ruby",
    theme: "hopscotch",
    lineNumbers: true,
    styleActiveLine: true,
    matchBrackets: true
  });

  var maestroValidateUrl = $("#maestro-info").data("maestro-url");

  console.log(myCodeMirror);
  console.log(editor);

  myCodeMirror.on("changes", function(doc, _){
    var sourceCode = doc.getValue();
    ragios.validateMaestro(maestroValidateUrl, sourceCode, ProcessMonitor.maestroSyntaxCheckResponse, ProcessMonitor.maestroError);
  });

  var httpCheck = false;
  var $form = $("#new_ragios_monitor");
  var syntaxErrorTemplate = _.template( $('#syntax-error-template').html() );
  var $error = $("#error");
  var $url = $("#url");
  var maestroTestUrl = $("#test-monitor").data("maestro-test-url");

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
      ragios.testMaestro(maestroTestUrl, url, ProcessMonitor.testMonitorResponse, ProcessMonitor.maestroError)
    },
    submitMonitor: function(e) {
      e.preventDefault();
      if(httpCheck) {
        $form.submit();
      } else {
        console.log("submit real browser monitor")
      }
    },
    testMonitorResponse: function(response) {
      console.log(response)
    },
    maestroSyntaxCheckResponse: function(response) {
      if (response.error) {
        $error.html(
          syntaxErrorTemplate(response)
        )
        $(".monitor-actions").addClass("disabled");
      } else {
        $error.html("");
        $(".monitor-actions").removeClass("disabled");
      }
    },
    maestroError: function() {

    }
  }

  ProcessMonitor.init();

});
