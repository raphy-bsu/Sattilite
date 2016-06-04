//= require jquery
//= require jquery_ujs
//= require bootstrap-sprockets
//= require_tree .

$(document).ready(function(){
    $('.alert .close').on('click', function(){
        $(this).closest('.alert').hide();
    });
});
