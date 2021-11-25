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
      url: '/assigned_to_update',
      type:'GET',
      url: '/update',
      type:'PATCH',
      data: {
        audition_id: $(this).attr("id"),
        id: $(this).attr("id"),
        assigned_to: this.value,
      }
    });
  });
});

$(document).on("click", ".modal-footer a", function(){
  let aud_id = $(this).attr("id");
  let val = $(this).attr("value");
  let email_content ;
  if(val == "Accepted"){
    let accept_email = "Hi [name],Thanks for submitting music to Audiosocket. We have listened to your link and would love to work with you. Please sign in to our artist portal here. There, you can update your artist profile, submit music, artworks, etc. The more assets you can give us the better. Once submitted, our team will review and will start the ingestion into our catalog.Thanks! Music Licensing Coordinator."
    let desc = CKEDITOR.instances['email_description'].setData(accept_email);
    $(document).on("click", ".btn-email", function(){
      desc = CKEDITOR.instances['email_description'].getData();
      email_content = desc.slice(3,-5);
      ajaxRequest(aud_id,val,email_content);
    });
  }
  else if(val == "Rejected"){
    let reject_email = "Hello [name], Thank you for submitting an audition. After careful review, we have decided the music you submitted is not a match for our current needs. Please understand, that while your music may not be a match this time, it certainly might be in the future as our clients’ needs are constantly changing. With that in mind, we encourage you to submit new music again in the future. Have a great day!"
    let desc = CKEDITOR.instances['email_description'].setData(reject_email);
    $(document).on("click", ".btn-email", function(){
      desc = CKEDITOR.instances['email_description'].getData();
      email_content = desc.slice(3,-5);
      ajaxRequest(aud_id,val,email_content);
    });
  }
  else if(val == "Deleted"){
    ajaxRequest(aud_id,val);
  }

  function ajaxRequest(aud_id, val, email_content){
    let audition_id = aud_id;
    let status = val;
    let email_description = email_content ;
    $.ajax({
      url: '/update_status_email',
      type:'PATCH',
      data: {
        id: audition_id,
        status: status,
        email_description: email_description
      },
      success: function(data){
        location.reload();
      }
    });
  }
});

