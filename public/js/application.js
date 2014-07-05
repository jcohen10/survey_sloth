$(document).ready(function() {
  // This is called after the document has loaded in its entirety
  // This guarantees that any elements we bind to will exist on the page
  // when we try to bind to them

var addDiv = $('#items');

var i = $('#items').size() + 1;
console.log(i);
console.log($('#items').size())

  $('#add').click(function(e) {
    $('<p><input type="text" id="new_choice" placeholder = "New Possible Answer" name="choice '+ i +'"><button id="remove_choice">Remove!</button></p>').appendTo(addDiv);
    i++;
    return false; //Investigate this.
  });

  $('#remove_choice').bind('click', function(e){
    if (i > 2) {
      console.log('yolo')
      // $(this).parents.remove();
      i--;
      console.log(i)
    }
  });

});
