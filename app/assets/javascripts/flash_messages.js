 var flashMessages = $('span#messages');
  flashMessages.each(function(i,element) {
    var type = $(element).data('type');
    var message = $(element).data('message');
    toastr[type](message,'',{"closeButton": true});
  });
