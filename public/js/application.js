$(document).ready(function() {
  // This is called after the document has loaded in its entirety
  // This guarantees that any elements we bind to will exist on the page
  // when we try to bind to them
   var data =[];
  $.ajax({
    url: "/survey/results/stats/",
    type: "POST",
    dataType: "json",
    success: function(response){

      console.log(response);
      console.log(response.response[0].possible_choice.times_chosen)
        for (var i =0; i < response.response.length; i++){
          data.push(response.response[i].possible_choice.times_chosen)
        }
    d3.select(".chart")
  .selectAll("div")
    .data(data)
  .enter().append("div")
    .style("width", function(d) { return d * 10 + "px"; })
    .text(function(d) { return d; });
    }
  });





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


