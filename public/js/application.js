$(document).ready(function() {
  // This is called after the document has loaded in its entirety
  // This guarantees that any elements we bind to will exist on the page
  // when we try to bind to them

var addDiv = $('#answers');

var i = $('#answers').size() + 1;
console.log(i);
console.log($('#items').size())

  $('#add').on('click', function(e) {
    $('<p><input type="text" id="new_choice" placeholder = "New Possible Answer" name="choice '+ i +'"><button href="#" id="remove_choice">Remove!</button></p>').appendTo(addDiv);
    i++;
    return false; //Investigate this.
  });

  $('#remove_choice').on('click', function(event){
    event.preventDefault();
    if (i > 2) {
      $(this).parents('p').remove(); //Does not work as intended need to come back to this.
      i--;
    }
    return false;
  });

});


