$(function() {
  var availableSearchTags, queryString;
  var resultElement = function(name, slug) {
      return '<a href="/leafly/stores/' + slug + '">' + name + '</a>'
    }

  $( "#search-form" ).autocomplete({
    // source: availableSearchTags
  });

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
      var storeName = response[0][0]
      var storeSlug = response[0][1]
      $('#search-results').html(resultElement(storeName, storeSlug))
      debugger;

    });
  });

});


