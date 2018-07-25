
  function initialize() {
    var lat = $('#map').data('lat');
    var lng = $('#map').data('lng');
    var name = $('#map').data('name');
    var imageLink = $('#map').data('image');

    var location = {
      lat: lat,
      lng: lng
    };
    var map = new google.maps.Map(document.getElementById('map'), {
      center: location,
      zoom: 14
    });
    var marker = new google.maps.Marker({map: map, position: location, title: name});
    var infoWindow = new google.maps.InfoWindow({content: '<div id="content"><img src="'+ imageLink +'"></div>'});
    infoWindow.open(map, marker);
  }
  google.maps.event.addDomListener(window, 'load', initialize);
