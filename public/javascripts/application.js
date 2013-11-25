// Put your application scripts here
$(document).ready(function() {
  window.wiselinks = new Wiselinks($('#content'));
  $(document).off('page:loading').on('page:loading', function(event, $target, render, url) {
    return console.log("Loading: " + url + " to " + $target.selector + " within '" + render + "'");
  });
  $(document).off('page:redirected').on('page:redirected', function(event, $target, render, url) {
    return console.log("Redirected to: " + url);
  });
  $(document).off('page:always').on('page:always', function(event, xhr, settings) {
    return console.log("Wiselinks page loading completed");
  });
  $(document).off('page:done').on('page:done', function(event, $target, status, url, data) {
    return console.log("Wiselinks status: '" + status + "'");
  });
  return $(document).off('page:fail').on('page:fail', function(event, $target, status, url, error, code) {
    return console.log("Wiselinks status: '" + status + "'");
  });
});