document.addEventListener("turbolinks:load", function() {
$(function() {
  $('.icon span').on('click', function(event) {
    $(this).toggleClass('active');
    $('.header-nav-sm').fadeToggle();
    event.preventDefault();
  });
});
})