$(document).ready(function() {
  // preventDefault if disabled
  $('a[disabled=disabled]').on('click', function(e) {
    e.preventDefault();
    return false;
  });
});