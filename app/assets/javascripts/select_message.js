$(document).ready(function() {
  $('button.list-group-item').on('click', function(e) {
    var message_id = $(this).data('message');
    var location_id = $(this).data('location');

    window.location.href = "/locations/" + location_id + "/messages/" + message_id;
  });
});
