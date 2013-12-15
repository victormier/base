$(document).ready(function() {
  // Best in place
  jQuery(".best_in_place").best_in_place();
  // Setup submit on change
  $("select.submit-on-change").change(function() {
    $(this).parents("form").submit();
  });

  // Set redactor textareas
  $('textarea.redactor').redactor({
    linebreaks: true,
    buttons: ['html', '|', 'formatting', '|', 'bold', 'italic', 'underline', '|',
'unorderedlist', 'orderedlist', 'outdent', 'indent', '|', 'link']
  });
});