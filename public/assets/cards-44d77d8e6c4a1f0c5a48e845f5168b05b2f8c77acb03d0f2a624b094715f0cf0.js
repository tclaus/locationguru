$(function() {
  var publish_key = $('#card-info').data('key');
  var stripe = Stripe(publish_key);
  var elements = stripe.elements();

  var card = elements.create('card', {
    hidePostalCode: true
  });
  card.mount('#card-element');
  card.on('change', function(event) {
    setOutcome(event);
  });

  function setOutcome(result) {
    var errorElement = document.getElementById('card-errors');
    errorElement.classList.remove('visible');

    if (result.token) {
      errorElement.textContent =' ';
      var form = $('#add-card');
      form.append($('<input type="hidden" name="stripeToken">').val(result.token.id));
      form.get(0).submit();

    } else if (result.error) {
      errorElement.textContent = result.error.message;
      errorElement.classList.add('visible');
    }
  }

  $('#add-card').on('submit', function(e) {
    e.preventDefault();
    var extraDetails = {
      name: $('input[name=cardholder-name]').value
    };
    stripe.createToken(card, extraDetails).then(setOutcome);
  });



});
