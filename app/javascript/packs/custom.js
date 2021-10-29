$(function() {
 function check_to_hide_or_show_add_link() {
   if ($('#colours .nested-fields:visible').length == 4) {
     $('#colours .links').hide();
   } else {
     $('#colours .links').show();
   }
 }

 $('#colours').on('cocoon:after-insert', function() {
   check_to_hide_or_show_add_link();
 });

 $('#colours').on('cocoon:after-remove', function() {
   check_to_hide_or_show_add_link();
 });

 check_to_hide_or_show_add_link();
});

$(document).ready(function() {
  $('#media').on('change', function() {
    var conceptName = $('#media').find(":selected").text();
    if (conceptName == "Other") {
        document.getElementById("ifYes").style.display = "block";
    } else {
        document.getElementById("ifYes").style.display = "none";
    }

  });
});
