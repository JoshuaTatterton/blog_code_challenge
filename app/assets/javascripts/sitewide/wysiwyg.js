var ready = function() {

  CKEDITOR.replace( "display", {
    autoGrow_onStartup: true,
    removePlugins: "toolbar,resize,elementspath",
  });

  CKEDITOR.on("instanceReady", function (ev) {
    if (ev.editor.name == "display") {
      var bodyelement = ev.editor.document.$.body;
      bodyelement.setAttribute("contenteditable", false);
    }
  });

};

$(document).ready(ready);
$(document).on("page:load", ready);