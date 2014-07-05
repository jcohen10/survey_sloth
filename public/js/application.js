$(document).ready(function() {
  // This is called after the document has loaded in its entirety
  // This guarantees that any elements we bind to will exist on the page
  // when we try to bind to them

var addDiv = $('#answers');

var i = $('#answers').size() + 1;
console.log(i);
console.log($('#items').size())

  $('#add').on('click', function(e) {
    event.preventDefault();
    $('<p><input type="text" id="new_choice" placeholder = "New Possible Answer" name="choice '+ i +'"><button  class="remove_choice">Remove!</button></p>').appendTo(addDiv);
    i++;
    return false; //Investigate this.
  });

  $(document).on('click', '.remove_choice', function(event){
      event.preventDefault();
      $(this).parents('p').remove();
  });

});


