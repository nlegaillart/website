$(function(){$("#btn_up").click(function(){$("html,body").animate({scrollTop:0},"slow")});$(window).scroll(function(){if($(window).scrollTop()<200){$("#btn_up").fadeOut()}else{$("#btn_up").fadeIn()}})})
/*$(function() {$(".lazyload").unveil();});*/
