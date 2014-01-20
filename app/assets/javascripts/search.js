// $(function() {
//   var queryString;
//   var resultElement = function(name, slug) {
//       return '<a href="/stores/' + slug + '" ' +
//       'id="review-modal-button" data-toggle="modal" data-target="#storeShowModal" ' +
//       '">' + name + '</a>'
//   };


//   $("#search-button").click(function(e) {
//     e.prevent_default;
//     queryString = $(".search-form").val();

//     var queryData;
//     queryData = { query : queryString };

//     $.ajax({
//       url: '/search',
//       type: 'POST',
//       dataType: 'json',
//       data: queryData,
//       error: function(response) {
//         var errors = response.responseJSON;
//         if(errors) {
//           $('#flash-section').html(errors);
//         }
//       }
//     }).done(function(response) {
//       for (store in response) {
//         debugger;
//         var storeSlug = response[store]["slug"];
//         var storeName = response[store]["name"];
//         var storeName = response[store]["name"];
//         var storeName = response[store]["name"];
//         var storeName = response[store]["name"];
//         $('#search-results').append(resultElement(response[store]) + "<br />")
//       }
//     });
//   });

// });

var addToMap = function(store) {
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
        'marker-color': '#f0a'
    }
  }).addTo(map);
};

var createMap = function() {

  console.log(L.mapbox.map())
  L.mapbox.map('main-map', 'examples.map-20v6611k').setView([39.7391667, -104.984167], 12);
};

$(function() {
  $("#search-button").click(function(e) {
    var queryString;
    
    e.preventDefault();
    queryString = $("#search-form").val();
    var queryData;
    queryData = { query : queryString };
    $.ajax({
      url: '/search',
      type: 'POST',
      dataType: 'json',
      data: queryData,
      success: function(response) {
        // createMap();
        for (store in response) {
          addToMap(response[store]);
        }
      },
      error: function(response) {
        var errors = response.responseJSON;
        if(errors) {
          $('#flash-section').html(errors);
        }
      }
    }).done(function(response) {
      addResults(response)
    })
  });
});

var addResults = function(response) {
  $('#search-results').html('');
  for (store in response) {
    console.log(response)
    var storeLink = '<a href="/stores/' + response[store]["slug"] + '" >' + response[store]["name"] + '</a><br>'
    $('#search-results').append(storeLink);

  }
}


