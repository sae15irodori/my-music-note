document.addEventListener("turbolinks:load", function() {
$(function() {
  $('.icon').on('click', function(event) {
    $(this).toggleClass('active');
    $('.header-nav-sm').fadeToggle();
    event.preventDefault();
  });
});
})