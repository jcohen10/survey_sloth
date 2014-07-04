$(document).ready(function() {
  // This is called after the document has loaded in its entirety
  // This guarantees that any elements we bind to will exist on the page
  // when we try to bind to them

  // See: http://docs.jquery.com/Tutorials:Introducing_$(document).ready()

//create three initial fields
var startingNo = 3;
var $node = "";
for(varCount=0;varCount<=startingNo;varCount++){
    var displayCount = varCount+1;
    $node += '<p><label for="var'+displayCount+'">Variable '+displayCount+': </label><input type="text" name="var'+displayCount+'" id="var'+displayCount+'"><span class="removeVar">Remove Variable</span></p>';
}
//add them to the DOM
$('#survey').prepend($node);
//remove a textfield
$('form').on('click', '.removeVar', function(){
   $(this).parent().remove();

});
//add a new node
$('#addVar').on('click', function(){
varCount++;
$node = '<p><label for="var'+varCount+'">Variable '+varCount+': </label><input type="text" name="var'+varCount+'" id="var'+varCount+'"><span class="removeVar">Remove Variable</span></p>';
$(this).parent().before($node);
});


});
