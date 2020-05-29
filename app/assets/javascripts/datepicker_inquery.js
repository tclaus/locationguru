$(function() {
  var unavailableDates = [];
  var regional = $("meta[property='language']").attr("content");
  var previewUrl = $('#datepicker').data('preview_url');
  var preloadUrl = $('#datepicker').data('preload_url');

  var booked_text = $('#datepicker').data('booked_text');
  var free_text = $('#datepicker').data('free_text');
  var requested_text = $('#datepicker').data('requested_text');
  var currentDate = new Date();
  currentDate.setHours(0,0,0);

const BOOKED = 'booked';
const INQUERY = 'inquery';

/*
  Check selected date with backend and print a message in UI
*/
  function selected(selected) {
    var start_date = $('#datepicker').datepicker('getDate');
    var input = {
      'start_date': start_date
    };
    // Ask backend whats up with this date
    $.ajax({
      url: previewUrl,
      data: input,
      success: function(data) {
        // Conflict: Date already reserved
        if (data.status === BOOKED) {
          $('#message').text(booked_text);
          $('#btn_book').attr('disabled', true);

        } else if (data.status === INQUERY) {
          $('#message').text(requested_text);
          $('#btn_book').attr('disabled', false);
          $('#reservation_start_date').val(start_date);

        } else { // Free
          $('#message').text(free_text);
          $('#btn_book').attr('disabled', false);
          $('#reservation_start_date').val(start_date);
        }
      }
    });
  }

  // Set Datepicker properties
  // Regional settings must pe part of options!
  // Retuns true/false and the css class to style the cell
var dpOptions = $.extend(
  {},
  $.datepicker.regional[regional],
  {
    numberOfMonths: 1,
    showButtonPanel: true,
    minDate: 0,
    maxDate: '18M',
    beforeShowDay: checkDate,
    onSelect: selected
  }
);

  $("#datepicker").datepicker(dpOptions);

  function checkDate(date) {

    // Reserved dates are marked. All other dates are free
    dmy = date.getDate() + "-" + (date.getMonth() + 1) + "-" + date.getFullYear();
    var found = inArray(dmy, unavailableDates);
    if (found) {
      // check status and return a css class
      if (found === BOOKED) {
        // Booked, not free
        return [true, 'blocked'];

      } else if (found === INQUERY) {
        // A request is outstanding, but not approved
        return [true, 'maybe-blocked'];

      } else {
        // Free ( no further information)
        return [true,'free'];
      }
    } else {
      // Not found => Free
      if (currentDate > date) {
        // If in the past, dont add a style
        return [true];
      }
      return [true, 'free'];
    }
  }

  function inArray(dmy, unavailableDates) {
    var foundValue = null;
    unavailableDates.forEach(function(currentValue, index, originalArray){
      if (dmy === currentValue.date) {
        foundValue = currentValue.status;
      }
    });
    return foundValue;
  }



  // Preload unavailable dates
  $.ajax({
    url: preloadUrl,
    dateTyp: 'json',
    success: function(data) {
      $.each(data, function(arrID, arrValue) {
          d = new Date(arrValue.start_date);
          unavailableDates.push({date: $.datepicker.formatDate('d-m-yy', d), status: arrValue.status});
      });
      $("#datepicker").datepicker("refresh");
    }
  });

});
