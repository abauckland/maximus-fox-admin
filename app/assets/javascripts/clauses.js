$(document).ready(function(){

$("select#subsection_id").change(function() {
    var subsection = $('select#subsection_id :selected').val();
    jQuery.get('/clauses/'+ template + '/update_clause_select');
});
 
});