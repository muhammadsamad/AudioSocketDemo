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
    console.log("h");
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

$(document).on("click", ".modal-footer a", function(e){
  e.preventDefault();
  let id = $(this).attr("id");
  let status = $(this).attr("value");
  if(status == "Accepted"){
    $("#email-accepted").removeClass("email-description");
    CKEDITOR.replace( 'editor2' );
    callingAJAX(id, status);
  }
  else if(status == "Rejected"){
    $("#email-rejected").removeClass("email-description");
    callingAJAX(id, status);
  }
  else if(status == "Deleted"){
    ajaxStatusEmailRequest(id,status);
  }
});

function ajaxStatusEmailRequest(id, status, email_description){
  $.ajax({
    url: '/change_status_send_email',
    type:'PATCH',
    data: {
      id: id,
      status: status,
      email_description: email_description
    },
    success: function(data){
      // location.reload();
    }
  });
}

function callingAJAX(id, status){
  $(document).on("click", ".btn-email", function(){
    let email_description = (CKEDITOR.instances['email_description'].getData()).slice(3,-5);
    ajaxStatusEmailRequest(id,status,email_description);
  });
}
