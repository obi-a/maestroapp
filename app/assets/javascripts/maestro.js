
//TODO: fix horrible code
var Maestro = {
  init: function($url, editor, validationUrl, testUrl, $console, syntaxErrorTemplate, resultsTemplate, loadingTemplate){
    this.$urlEl = $url;
    this.testUrl = testUrl;
    this.$console = $console;
    this.resultsTemplate = resultsTemplate;
    this.syntaxErrorTemplate = syntaxErrorTemplate;
    this.loadingTemplate = loadingTemplate;
    this.editor = editor;
    this.editor.on("changes", function(doc, _){
      var sourceCode = doc.getValue();
      ragios.validateMaestro(validationUrl, sourceCode, Maestro.syntaxCheckResponse, Maestro.error);
    });
  },
  test: function() {
    var url = Maestro.$urlEl.val();
    var sourceCode = Maestro.editor.getValue();
    if (url.length > 0) {
      Maestro.$console.html(
        Maestro.loadingTemplate
      )
      ragios.testMaestro(Maestro.testUrl, url, sourceCode, Maestro.testResponse, Maestro.error)
    } else {
      Maestro.$console.html("<div class=\"search-results\">Fill in URL field before running a test.</div>");
    }
  },
  testResponse: function(result) {
    Maestro.$console.html(
      Maestro.resultsTemplate(result)
    )
  },
  syntaxCheckResponse: function(response) {
    if (response.error) {
      Maestro.$console.html(
        Maestro.syntaxErrorTemplate(response)
      )
    } else {
      Maestro.$console.html("");
    }
  },
  error: function(xhr) {
    var response = $.parseJSON(xhr.responseText);
    ProcessMonitor.message.append(
      ProcessMonitor.messageTemplate({message: "Error", alert: "alert", response: JSON.stringify(response)})
    );
    $(document).foundation('alert', 'reflow');
  }
}
