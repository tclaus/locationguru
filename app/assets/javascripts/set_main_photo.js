$(function () {
  var set_main_photo_url = "/photos/main_photo";

  $('.fa-star').on('click', function (event) {
    if (event.currentTarget.classList.contains('fas')) {
      // Set as Main - if already main, do nothing
      return;
    }
    var location_id = $(event.currentTarget).data('location-id');
    var photo_id = $(event.currentTarget).data('photo-id');

    post_selected(location_id, photo_id);

    // Toogle data
    icons = document.getElementsByClassName("fa-star");

    for (i = 0; i < icons.length; i++) {
      if (icons[i] != event.currentTarget) {
          icons[i].classList.remove('fas');
          icons[i].classList.add('far');
        }
      }
      event.currentTarget.classList.remove('far');
      event.currentTarget.classList.add('fas');
  }
);

function post_selected(location_id, photo_id) {
  var input = {
    'location_id': location_id,
    'photo_id' : photo_id
  };
  // Set new main photo to backend
  $.ajax({
    url: set_main_photo_url,
    method: 'POST',
    data: input,
    success: function(data) {
      console.log("Succesful set main photo");
      location.reload();
    }
  });
}

});
