$(document).ready(function() {
  $('button.list-group-item').on('click', function(e) {
    var elem = $(this);
    var message_id = $(this).data('message');
    var location_id = $(this).data('location');
    if (e.target.tagName != 'I') {
      window.location.href = "/locations/" + location_id + "/messages/" + message_id;
    }
  });

  // Capture delete-event and delete item
  $('i.fa.fa-trash').on('click', function(e) {
    var message_id = $(this).data('message');
    $('#' + message_id).slideUp( 400 );
    // Calc the unread counter, if needed
      $.get( "/dashboard/unread_count_json", function(data, resp ) {
        if (resp == "success") {
          $('#unread_count').text(data);
        }
  });

  });

});
