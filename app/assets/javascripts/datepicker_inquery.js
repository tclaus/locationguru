$( function() {

  var regional = $("meta[property='language']").attr("content");

    $( "#datepicker" ).datepicker({
      numberOfMonths: 1,
      showButtonPanel: true
    });

    $( "#datepicker" ).datepicker( "option",
        $.datepicker.regional[regional]
      );

  } );
