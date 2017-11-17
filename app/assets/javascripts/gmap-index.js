document.addEventListener("turbolinks:load", function() {
   var map = new GMaps({
     div: '#map',
     lat: 30.2884208,
     lng: -81.6029046
   });
   window.map = map;

   var locations = JSON.parse(document.querySelector("#map").dataset.locations);
   window.locations = locations;

   locations.forEach(function(location) {
     if (location.latitude && location.longitude) {
       var marker = map.addMarker({
         lat: location.latitude,
         lng: location.longitude,
         title: location.address,
         infoWindow: {
           content: `<p><a href='/locations/${location.id}'>${location.address}</a></p>`
         }
       });
     }
   });

	var l = document.querySelector("#map").dataset.l;
	  if (l) {
	    var latlngs   = l.split(',');
	    var southWest = new google.maps.LatLng(latlngs[0], latlngs[1]);
	    var northEast = new google.maps.LatLng(latlngs[2], latlngs[3]);
	    var bounds    = new google.maps.LatLngBounds(southWest, northEast);
	    map.fitBounds(bounds, 0);
	  } else {
	    map.fitZoom();
	  }

	  document.querySelector("#redo-search").addEventListener("click", function(e) {
	    e.preventDefault();

	    var bounds = map.getBounds();
	    var location = bounds.getSouthWest().toUrlValue() + "," + bounds.getNorthEast().toUrlValue();

	    Turbolinks.visit(`/locations?l=${location}`);
	  });
 });

   // var bounds = new google.maps.LatLngBounds();
   //     bounds.extend(marker.position);
   // map.fitBounds(bounds);
