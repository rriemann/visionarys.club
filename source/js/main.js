// Custom JavaScript here
// =======================================================================

//= require jquery
//= require jquery.easing/jquery.easing
//= require jquery.stellar/jquery.stellar
//= require mapbox.js/mapbox.uncompressed
//= require formstone/dist/js/core
//= require formstone/dist/js/transition
//= require formstone/dist/js/background

//= require _bootstrap
//= require _grayscale


$(".video-bg").background({
  source: {
    // poster: "path/to/poster.jpg",
    // video: "//www.youtube.com/embed/vLUNWYt3q1w"
    // video: "//www.youtube.com/embed/J25CjWf61ks" yesmite (werbung)
    // video: "//www.youtube.com/embed/1HZ0iSwqsWA"
    // video: "//www.youtube.com/embed/oaU9ZhAi6oU" video background south america
    poster: "/img/20120521-yosemite-327.jpg", // http://www.projectyose.com/ https://vimeo.com/87701971
    // video: "//www.youtube.com/embed/fb4dpcIYTrc" // night vision cities europe
  }
});

/*
$( "#toggle-video" ).click(function() {
  $("#toggle-icon").toggleClass("fa-play");
  $("#toggle-icon").toggleClass("fa-pause");

  if($("#toggle-icon").hasClass("fa-play")){
    $(".video-bg").background("pause");
  } else {
    $(".video-bg").background("play");
  }
});
*/

$.stellar({
  horizontalScrolling: false
});
