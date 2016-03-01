$(document).ready(function() {
  $(".article_writer").hide();
  $(".article_editor").hide();

  $("#new_article").click(function() {
    $(".article_writer").show();
  });

  $(".edit_button").click(function() {
    var id = $(this).attr("id");

    $("#article_editor_"+id).show();
    $("#article_display_"+id).hide();
  });

});