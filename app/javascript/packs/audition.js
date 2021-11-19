$(document).ready(function() {
  $("#other-text-field").addClass("display-none");
  $('#media').on('change', function() {
    let conceptName = $('#media').find(":selected").text();
    if (conceptName == "Other") {
      $("#other-text-field").removeClass("display-none");
    } else {
      $("#other-text-field").addClass("display-none");
    }
  });

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

  $('.select').on('change', function() {
    $.ajax({
      url: "/auditions/" + $(this).attr("id"),
      type: 'PATCH',
      data: {
        assigned_to: this.value
      },
     success: function()
     {
      alert("Audition has been assigned");
     },
     error: function()
     {
      alert("Audition has not been assigned");
     }
    });
  });
});
