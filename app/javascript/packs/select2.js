import $ from 'jquery';
import 'select2';
import 'select2/dist/css/select2.css';

$(document).ready(function() {
  $('.genre-multiple').select2({
    closeOnSelect: false;
  });
});
