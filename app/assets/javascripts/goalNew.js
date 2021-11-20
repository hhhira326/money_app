$(function() {

  if (gon.latest) {
    $('.totalGoal').html(`${gon.latestDay}までに<br>￥${gon.latest.goalSavings.toLocaleString()}貯金`);
  }
  var $checkTr = $('.checkbox[value="true"]').parents('tr');
  let nearId = [];
  
  $.each(gon.nearDeadline, function(index, val) {
    $(`.checkbox[name= ${val.id}]`).parents('tr').css('background-color', 'pink');
    nearId.push(val.id)
  });
  
  $('.checkbox[value="true"]').prop("checked", true);
  $checkTr.css('background-color','#c9c9c9');

  $('.checkbox').click(function() {
    let checkVal;
    let checkId;
    if ($(this).prop('checked')){
      $(this).parents('tr').css('background-color','#c9c9c9');
      $(this).val('true')
      checkVal = $(this).val();
      checkId = $(this).attr("name");
    } else {
      $(this).parents('tr').css('background-color','');
      $(this).val('false');
      checkVal = $(this).val();
      checkId = $(this).attr("name");

      $.each(nearId, function(index, value) {
        if (value == checkId) {
          $(`.checkbox[name=${checkId}]`).parents('tr').css('background-color', 'pink');
          return false;
        } else {
          $(`.checkbox[name=${checkId}]`).parents('tr').css('background-color', '');
          return true;
        }
      })
      
    } 
    $.ajax({
      type: 'post',
      url: '/users/:user_id/check',
      data: {
        checkVal: checkVal,
        checkId: checkId,
      },
      dataType: 'json'
    })
    .done(function(data) {
      console.log(data);
    })
  });
});