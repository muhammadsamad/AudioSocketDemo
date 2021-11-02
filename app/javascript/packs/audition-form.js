$(function() {
 function check_to_hide_or_show_add_link() {
   if ($('#link-fields .nested-fields:visible').length == 4) {
     $('#link-fields .links').hide();
   } else {
     $('#link-fields .links').show();
   }
 }

 $('#link-fields').on('cocoon:after-insert', function() {
   check_to_hide_or_show_add_link();
 });

 $('#link-fields').on('cocoon:after-remove', function() {
   check_to_hide_or_show_add_link();
 });

 check_to_hide_or_show_add_link();
});

$(document).ready(function() {
  $('#media').on('change', function() {
    var conceptName = $('#media').find(":selected").text();
    if (conceptName == "Other") {
        document.getElementById("other-text-field").style.display = "block";
    } else {
        document.getElementById("other-text-field").style.display = "none";
    }

  });
});
