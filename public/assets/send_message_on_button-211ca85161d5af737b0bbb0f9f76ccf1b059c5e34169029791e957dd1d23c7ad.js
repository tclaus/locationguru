$(function () {
  $('#mail_to_link').on('click', function (event) {
      event.preventDefault();
    var email = $(this).data('mail');
    var subject = $(this).data('subject');
    var emailBody = $(this).data('body');
    window.location = 'mailto:' + email + '?subject=' + subject + '&body=' +   emailBody;
  });
});
