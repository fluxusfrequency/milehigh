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
      // var i = 0;
      //   debugger
      for (store in response) {
        var storeName = response[store][0]
        var storeSlug = response[store][1]
        $('#search-results').append(resultElement(storeName, storeSlug) + "<br />")
      }
    });
  });

});


