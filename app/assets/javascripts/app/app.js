
var ready = function(){
  $('.field_with_errors').parent().addClass('has-error');
  $('[data-toggle="tooltip"]').tooltip();
  $('.bootsy').wysihtml5({
    "image": false,
    "color": false,
    "link": false,
    "locale": window.locale
  });
}

$(document).ready(ready);
$(document).on("page:load", ready);