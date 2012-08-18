$(document).ready(function(){

$(function(){                                                      
  $('.custom_list .ui-block-a').css({'width':(($(window).width())-350)+"px"});                                                                 
  $(window).resize(function(){                                     
  $('.custom_list .ui-block-a').css({'width':(($(window).width ())-350)+"px"});
  });
});

 
});