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
//= require clauses.js
//= require jquery_ujs
//= require jquery-ui-1.8.9.custom.min.js
//= require jquery.mobile


//following jquery loads after DOM is ready
$(document).ready(function(){

//set size of list text div depending on window size

$(function(){                                                      
  $('.ui-li div#text_content').css({'width':(($(window).width())-230)+"px"});                                                                
  $(window).resize(function(){                                     
  $('ul #text_content').css({'width':(($(window).width ())-230)+"px"});
  });
});
 
 $("select#subsection_id").change(function() {
    var subsection = $('select#subsection_id :selected').val();
    jQuery.get('/clauses/'+ template + '/update_clause_select');
});
 
  
});

