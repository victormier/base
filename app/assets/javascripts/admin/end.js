$(document).ready(function() {
  // Set redactor textareas       
  $('textarea.redactor').redactor({
    linebreaks: true,
    buttons: ['html', '|', 'formatting', '|', 'bold', 'italic', 'underline', '|',
'unorderedlist', 'orderedlist', 'outdent', 'indent', '|', 'link']
  });
});