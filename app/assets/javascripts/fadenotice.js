$(document).ready(function() {
   window.setTimeout("fadeMyDiv();", 5000); //call fade in 3 seconds
 }
)

function fadeMyDiv() {
   $(".noticeFade").fadeOut('2000');
}
