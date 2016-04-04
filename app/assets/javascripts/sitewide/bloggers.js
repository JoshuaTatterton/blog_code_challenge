var ready = function() {

  $(".sign_up_form").hide();
  
  $("#sign_up").click(function() {
    if ($(".sign_up_form").css("display") == "none") {
      $(".sign_up_form").show();
    } else {
      $(".sign_up_form").hide();
    }
  });

};

$(document).ready(ready);
$(document).on("page:load", ready);