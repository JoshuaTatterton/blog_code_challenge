var ready = function() {

  $(".comment_new").hide();

  $("#comment").click(function() {
    if ($(".comment_new").css("display") == "none") {
      $(".comment_new").show();
    } else {
      $(".comment_new").hide();
    }
  });

};

$(document).ready(ready);
$(document).on("page:load", ready);