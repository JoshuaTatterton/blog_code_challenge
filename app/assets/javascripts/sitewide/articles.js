var ready = function() {

  $(".article_writer").hide();
  $(".article_editor").hide();
  
  $("#new_article").click(function() {
    if ($(".article_writer").css("display") == "none") {
      $(".article_writer").show();
    } else {
      $(".article_writer").hide();
    }
    
  });

  $(".edit_button").click(function() {
    var id = $(this).attr("id");

    $("#article_editor_" + id).show();
    $("#article_display_" + id).hide();
  });

};

$(document).ready(ready);
$(document).on("page:load", ready);