//= require jquery2
//= require vendor/video.min

$(function(){
  "use strict";
  $('#search-icon, .overlay-search').on('click', function(){
    $('.navbar-search-form').toggle();
    $('.overlay-search').toggle();
    if ($('.navbar-search-form').is(':visible')) {
      $('#q').focus();
    }
  });

  $(document).on('keyup',function(evt) {
    if (evt.keyCode == 27 && $('.overlay-search').is(':visible')) {
      $('.navbar-search-form').toggle();
      $('.overlay-search').toggle();
    }
  });
});
