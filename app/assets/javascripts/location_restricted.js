$('.toggle_restriced').bind('ajax:success', function(event) {
  if (event.detail[0].isRestricted == true) {
    event.currentTarget.children[0].classList = "fas fa-check";
  } else {
    event.currentTarget.children[0].classList = "far fa-minus";
  }
});
