$(function() {
    $("#student_search input").keyup(function() {
        $.get($("#student_search").attr("action"), $("#student_search").serialize(), null, "script");
        return false;
    });
});

// application.js
//$(function() {
//  $("#products th a, #products .pagination a").live("click", function() {
//    $.getScript(this.href);
//    return false;
//  });
//  $("#products_search input").keyup(function() {
//    $.get($("#products_search").attr("action"), $("#products_search").serialize(), null, "script");
//    return false;
//  });
//});
