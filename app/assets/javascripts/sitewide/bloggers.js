var ready = function() {

  $(".sign_up_form").hide();
  $(".sign_in_form").hide();
  
  $("#sign_up").click(function() {
    if ($(".sign_up_form").css("display") == "none") {
      $(".subscribe_form").hide()
      $(".sign_in_form").hide();
      $(".sign_up_form").show();
    } else {
      $(".sign_up_form").hide();
    }
  });

  $("#sign_in").click(function() {
    if ($(".sign_in_form").css("display") == "none") {
      $(".subscribe_form").hide()
      $(".sign_up_form").hide();
      $(".sign_in_form").show();
    } else {
      $(".sign_in_form").hide();
    }
  });

};

$(document).ready(ready);
$(document).on("page:load", ready);