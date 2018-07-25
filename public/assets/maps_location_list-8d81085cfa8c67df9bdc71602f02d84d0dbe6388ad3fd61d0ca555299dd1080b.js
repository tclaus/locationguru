
  function initialize(locations) {
    if (locations instanceof Array) {
      if (locations.length > 0) {
        $('#map').show();
        var location = {
          lat: locations[0].latitude,
          lng: locations[0].longitude
        };

        var map = new google.maps.Map(document.getElementById('map'), {
          center: location,
          zoom: 12
        });

        var marker;
        var infoWindow;

        locations.forEach(function (aLocation) {
          marker = new google.maps.Marker({
            position: {
              lat: aLocation.latitude,
              lng: aLocation.longitude
            },
            map: map
          });

          infoWindow = new google.maps.InfoWindow({
            content: "<div class='map_price'> " + aLocation.listing_name + " </div>"
          });
          infoWindow.open(map, marker);
        });
      } else {
        $('#map').hide();
      }
    }
  }

  var locationData = $('#map').data('mapdata');
  if (locationData) {
    google.maps.event.addDomListener(window, 'load', initialize(locationData));
  }
;
