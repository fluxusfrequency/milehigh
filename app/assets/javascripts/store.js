$(function() {
  (function() {
    var params = document.body.baseURI.split('/');
    var storeSlug = params[params.length-1]
    queryData = { query : storeSlug };
    $(document).ready(function(e) {
      $.ajax({
        url: '/search',
        type: 'POST',
        dataType: 'json',
        data: queryData,
        success: function(response) {
          // console.log(response[0]["lat"]);
          // console.log(response[0]["lng"]);
          var map = L.mapbox.map('single-store-map', 'examples.map-20v6611k').setView([response[0]["lat"], response[0]["lng"]], 16);
          addToMap(response[0], map);

        },
        error: function(response) {
          var errors = response.responseJSON;
          if(errors) {
            $('#flash-section').html(errors);
          }
        }
      })
    })


    var addToMap = function(store, map) {
      L.mapbox.markerLayer({
        // this feature is in the GeoJSON format: see geojson.org
        // for the full specification
        type: 'Feature',
        geometry: {
            type: 'Point',
            // coordinates here are in longitude, latitude order because
            // x, y is the standard for GeoJSON and many formats
            coordinates: [parseFloat(store["lng"]), parseFloat(store["lat"])]
        },
        properties: {
            title: "<a href='/'>" + store["name"] + '</a>',
            description: store["address"],
            // one can customize markers by adding simplestyle properties
            // http://mapbox.com/developers/simplestyle/
            'marker-size': 'large',
            'marker-color': '#f0a'
        }
      }).addTo(map);
    };
  })();
});
