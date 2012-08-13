// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require posts.js
//= require jquery_ujs
//= require jquery.mobile
//= require nicEdit


//following jquery loads after DOM is ready
$(document).ready(function(){

//set size of list text div depending on window size

$(function(){                                                      
  $('.ui-li div#text_content').css({'width':(($(window).width())-230)+"px"});                                                                
  $(window).resize(function(){                                     
  $('ul #text_content').css({'width':(($(window).width ())-230)+"px"});
  });
});
 
  
});

