var ready = function() {

  $(".subscribe_form").hide()

  $("#subscribe").click(function() {
    if ($(".subscribe_form").css("display") == "none") {
      $(".sign_up_form").hide();
      $(".sign_in_form").hide();
      $(".subscribe_form").show();
    } else {
      $(".subscribe_form").hide();
    }
  });

};

$(document).ready(ready);
$(document).on("page:load", ready);