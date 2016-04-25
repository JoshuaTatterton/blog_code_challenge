var ready = function() {

  $(".article_writer").hide();
  $(".article_editor").hide();
  $("#markdown_content_container").hide();
  $("#wysiwig_content_container").hide();

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

  $("#article_option_markdown").click(function() {
    $("#wysiwig_content_container").hide();
    $("#markdown_content_container").show();
  });

  $("#article_option_wysiwyg").click(function() {
    $("#markdown_content_container").hide();
    $("#wysiwig_content_container").show();
  });

  $("#cancel_writing").click(function() {
    $(".article_writer").hide();
  });

  $("#cancel_edit").click(function() {
    $(".article_editor").hide();
  });
};

$(document).ready(ready);
$(document).on("page:load", ready);