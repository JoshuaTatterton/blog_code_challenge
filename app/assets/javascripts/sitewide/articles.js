var ready = function() {

  $(".article_editor").hide();

  $(".edit_button").click(function() {
    var id = $(this).attr("id");

    $("#article_editor_" + id).show();
    $("#article_display_" + id).hide();
  });

  $("#cancel_edit").click(function() {
    $(".article_editor").hide();
  });
};

$(document).ready(ready);
$(document).on("page:load", ready);