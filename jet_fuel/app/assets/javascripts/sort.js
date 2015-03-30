$(document).ready(function(){
  $("#search-form").keyup(function(){
    var filter = $(this).val();

    $("#url-list > tr").each(function(){
      if ($(this).text().search(new RegExp(filter, "i")) < 0) {
        $(this).hide();
      } else {
        $(this).show();
      }
    });
  });
});
