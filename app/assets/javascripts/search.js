$(function() {
  var queryString;
  var resultElement = function(name, slug) {
      return '<a href="/leafly/stores/' + slug + '" ' +
      'id="review-modal-button" data-toggle="modal" data-target="#storeShowModal" ' +
      '">' + name + '</a>'
  };


  $("#search-button").click(function(e) {
    e.prevent_default;
    queryString = $("#search-form").val();

    var queryData;
    queryData = { query : queryString };

    $.ajax({
      url: '/search',
      type: 'POST',
      dataType: 'json',
      data: queryData,
      error: function(response) {
        var errors = response.responseJSON;
        if(errors) {
          $('#flash-section').html(errors);
        }
      }
    }).done(function(response) {
      for (store in response) {
        debugger;
        var storeSlug = response[store]["slug"];
        var storeName = response[store]["name"];
        var storeName = response[store]["name"];
        var storeName = response[store]["name"];
        var storeName = response[store]["name"];
        $('#search-results').append(resultElement(response[store]) + "<br />")
      }
    });
  });

});


