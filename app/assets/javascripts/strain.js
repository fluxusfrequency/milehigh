$(function() {
  (function() {
    $(document).ready(function(e) {
      var params = document.body.baseURI.split('/');
      var strainSlug = params[params.length-1]
      queryData = { query : strainSlug };
      $.ajax({
        url: '/strain',
        type: 'POST',
        dataType: 'json',
        data: queryData,
        success: function(response) {
          var map = L.mapbox.map('strain-map', 'examples.map-20v6611k').setView([39.7391667, -104.984167], 11);
          var counter = 1
          for(store in response) {
            addToMap(response[store], counter, map);
            counter++;
          }
        },
        error: function(response) {
          var errors = response.responseJSON;
          if(errors) {
            $('#flash-section').html(errors);
          }
        }
      }).done(function(response) {
        addResults(response);
      });
    });
    var addToMap = function(store, counter, map) {
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
          title: store["name"],
          description: store["address"],
          // one can customize markers by adding simplestyle properties
          // http://mapbox.com/developers/simplestyle/
          'marker-size': 'large',
          'marker-color': '#f0a',
          'marker-symbol': counter
      }
    }).addTo(map);
    };

    var addResults = function(response) {
      $('#strain-stores p').html('');
      var counter = 1;
        for (var store in response) {
          console.log(response[store]);
          var storeLink = '<a href="/stores/' + response[store]["slug"] + '" >' + counter + '. ' + response[store]["name"] + '</a><br>';
          var storeAddress = '<p>' + response[store]["address"] + ", " + response[store]["city"] + ', ' + response[store]["state"] + response[store]["zipcode"] + '<br />';
          $('#strain-stores').append(storeLink + storeAddress); 
          counter++;
        }
      // }
    };

  })();
});
