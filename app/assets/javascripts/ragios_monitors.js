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

  console.log(myCodeMirror);
  console.log(editor);

  var httpCheck = false;
  var $form = $("#new_ragios_monitor");

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
    }
  }

  ProcessMonitor.init();

});
