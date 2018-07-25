
$(function () {
  var rating = $('#average_rating').data('value');
  $('#average_rating').raty({path: '/assets', readOnly: true, score: rating});
});
