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

  var maestroUrl = $("#maestro-info").data("maestro-url");

  console.log(myCodeMirror);
  console.log(editor);

  myCodeMirror.on("changes", function(doc, _){
    var sourceCode = doc.getValue();
    ragios.validateMaestro(maestroUrl, sourceCode, ProcessMonitor.maestroResponse, ProcessMonitor.maestroError);
  });

  var httpCheck = false;
  var $form = $("#new_ragios_monitor");
  var syntaxErrorTemplate = _.template( $('#syntax-error-template').html() );
  var $error = $("#error");

  var ProcessMonitor = {
    init: function() {
      $("#http_check").on("change", this.showHttpCheck);
      $("#real_browser_monitor").on("change", this.showRealBrowserMonitor);
      $("#submit-monitor").on("click", this.submitMonitor);
    },
    showHttpCheck: function() {
      httpCheck = true;
      $("#validations").hide("slow");
    },
    showRealBrowserMonitor: function() {
      httpCheck = false;
      $("#validations").show("slow");
    },
    submitMonitor: function(e) {
      e.preventDefault();
      if(httpCheck) {
        $form.submit();
      } else {
        console.log("submit real browser monitor")
      }
    },
    maestroResponse: function(response) {
      if (response.error) {
        $error.html(
          syntaxErrorTemplate(response)
        )
      } else {
        $error.html("")
      }
    },
    maestroError: function() {

    }
  }

  ProcessMonitor.init();

});
