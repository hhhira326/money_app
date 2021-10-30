$(function() {
  $('.checkbox').click(function() {
    if($(this).prop('checked')){
      $(this).parents('tr').css('background-color','#c9c9c9');
      // $(this).parents('tr:nth-child(odd)').css('background-color','#c9c9c9');
    }else{
      $(this).parents('tr').css('background-color','');
    } 
  })
});