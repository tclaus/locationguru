$(function() {
  var unavailableDates = [];
  var regional = $("meta[property='language']").attr("content");
  var previewUrl = $('#datepicker').data('preview_url');
  var preloadUrl = $('#datepicker').data('preload_url');

  
 $( "#datepicker" ).datepicker( $.datepicker.regional[regional] );

  function checkDate(date) {
    // reserved dates are marked. all other dates are free
    dmy = date.getDate() + "-" + (date.getMonth() + 1) + "-" + date.getFullYear();
    return [$.inArray(dmy, unavailableDates) == -1];
  }

  $.ajax({
    url: preloadUrl,
    dateTyp: 'json',
    success: function(data) {
      $.each(data, function(arrID, arrValue) {
        if (arrValue.status === 'booked') {
          d = new Date(arrValue.start_date);
          unavailableDates.push($.datepicker.formatDate('d-m-yy', d));
        }
      });

      $("#datepicker").datepicker({
        numberOfMonths: 1,
        showButtonPanel: true,
        minDate: 0,
        maxDate: '18M',
        beforeShowDay: checkDate,
        onSelect: function(selected) {

          var start_date = $('#datepicker').datepicker('getDate');
          var input = {
            'start_date': start_date
          };

          $.ajax({
            url: previewUrl,
            data: input,
            success: function(data) {
              console.log('Backend answered successfully', data);
              // Conflict: Date already reserved
              if (data.status == 'inquery') {
                $('#message').text("These date is requested but still free.");
                $('#btn_book').attr('disabled', false);
              } else if (data.status == 'booked') {
                $('#message').text("This date is booked.");
                $('#btn_book').attr('disabled', true);
              } else {
                $('#message').text("This date is free ");
                $('#btn_book').attr('disabled', false);
                $('#reservation_start_date').val(start_date);

              }
            }
          });
        }
      });
    }
  });

});
