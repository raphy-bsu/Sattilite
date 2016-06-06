//= require jquery
//= require jquery_ujs
//= require bootstrap-sprockets
//= require fancybox/source/jquery.fancybox.pack.js
//= require_tree .

$(document).ready(function(){
    $('.alert .close').on('click', function(){
        $(this).closest('.alert').hide();
    });
});

$(".fancy").fancybox();
