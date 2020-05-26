
  $('a[data-remote]').on('ajax:success', function(event) {
    // Remove the full photo panel
    event.target.parentElement.parentElement.parentElement.parentElement.remove();
  });
