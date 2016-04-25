var ready = function() {

  $("#advanced_search_button").click(function() {
    if ($("#advanced_search_options").css("display") == "none") {
      $("#advanced_search_options").show();
    } else {
      $("#advanced_search_options").hide();
    }
  });

};

$(document).ready(ready);
$(document).on("page:load", ready);