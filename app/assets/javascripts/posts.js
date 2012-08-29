$(document).ready(function(){

$("#clone_template_id").change(function() {
    var template = $('select#clone_template_id :selected').val();
    jQuery.get('/clauses/'+ template + '/update_clause_select');
});
 
});