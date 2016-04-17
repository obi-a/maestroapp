$(function () {
  $(document).foundation();

  var el = document.getElementById("editor");
  var myCodeMirror = CodeMirror(el, {
    value: "title.with_text(\"hello world\")\n",
    mode:  "ruby",
    theme: "hopscotch",
    lineNumbers: true,
    styleActiveLine: true,
    matchBrackets: true
  });

  console.log(myCodeMirror);
  console.log(el);


});
