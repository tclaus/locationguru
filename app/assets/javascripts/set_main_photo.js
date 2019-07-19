$(function () {
  $('.fa-star').on('click', function (event) {
    if (event.currentTarget.classList.contains('fas')) {
      // Set as Main - if already main, do nothing
      return;
    }

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
)
});
