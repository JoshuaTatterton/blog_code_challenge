var ready = function() {

  $(".commenter").hide();

  $("#comment").click(function() {
    if ($(".commenter").css("display") == "none") {
      $(".commenter").show();
    } else {
      $(".commenter").hide();
    }
  });

};

$(document).ready(ready);
$(document).on("page:load", ready);