$.get("http://localhost:3000/map/markers")
.done(function(addresses){
  list = addresses.map(function(address){
    return {
      "lat": address.coordinates.lat,
      "lng": address.coordinates.lng,
      "infowindow": address.city
    }
  })

  console.log(list)
  handler = Gmaps.build('Google');
  handler.buildMap({ provider: {}, internal: { id: 'map' } }, function () {
      markers = handler.addMarkers(list);

    handler.bounds.extendWith(markers);
    handler.fitMapToBounds();
});
})