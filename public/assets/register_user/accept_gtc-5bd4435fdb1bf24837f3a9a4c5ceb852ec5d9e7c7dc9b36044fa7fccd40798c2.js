$(document).ready(function() {
  $('#accept_gtc').on('change', function() {
    console.log('changes checkbox');
    $('#submit').prop('disabled',
      !$('#accept_gtc').prop('checked'));
  });
});
