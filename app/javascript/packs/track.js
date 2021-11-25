$(document).ready(function() {
  $('.social-field').attr("value"," ");
  $("#social-link").on('click',function(event) {
    event.preventDefault();
    let html_social_link = $('.social').html();
    $('.social').after(html_social_link);
  });
});
