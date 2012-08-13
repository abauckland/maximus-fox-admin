# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/


$(document).ready(function(){



$(function(){                                                      
  $('.custom_list .ui-block-a').css({'width':(($(window).width())-350)+"px"});                                                                 
  $(window).resize(function(){                                     
  $('.custom_list .ui-block-a').css({'width':(($(window).width ())-350)+"px"});
  });
});

  
  
});