(function() {
var markers = [];

var addToMap = function(store, counter) {
  var marker = L.mapbox.markerLayer({
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
  });
  markers.push(marker);
  marker.addTo(map);
};

var createMap = function() {
  console.log(L.mapbox.map())
  L.mapbox.map('main-map', 'examples.map-20v6611k').setView([39.7391667, -104.984167], 12);
};

$(function() {
  $("#search-button").click(function(e) {
    var queryString, queryData;
    e.preventDefault();
    queryString = $("#search-form").val();
    queryData = { query : queryString };

    $.ajax({
      url: '/search',
      type: 'POST',
      dataType: 'json',
      data: queryData,
      success: function(response) {
        clearMarkers();
        var counter = 1;
        for (var store in response) {
          addToMap(response[store], counter);
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
});

var addResults = function(response) {
  $('#search-results').html('');
  if (response.length === 0) {
    $('#search-results').append("Sorry, no stores matched your search.");
  } else {
    var counter = 1;
    for (var store in response) {
      var storeLink = '<a href="/stores/' + response[store]["slug"] + '" >' + counter + '. ' + response[store]["name"] + '</a><br>';
      var storeAddress = '<p>' + response[store]["address"] + ", " + response[store]["city"] + ', ' + response[store]["state"] + response[store]["zipcode"] + '</p>';
      $('#search-results').append(storeLink + storeAddress);
      counter++;
    }
  }
};

var clearMarkers = function() {
  for (var m in markers) {
    markers[m].clearLayers();
  }
};
})();
