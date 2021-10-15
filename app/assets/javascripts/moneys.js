// $(function() {
  $(document).on('turbolinks:load',(function(){

    $('#searchDate').change(function() {
      var searchDate = $(this).val();
      console.log(searchDate);
      var pass = location.pathname.split("/");
      var user_id = pass[2];  
      console.log(user_id)
      $.ajax({
        type: 'GET',
        url: '/users/:user_id/search',
        data: {
          searchDate: searchDate},
        dataType: 'json'
      })
      .done(function(getData) {
        console.log(getData);    
        var incomes = getData.incomes
        var expenses = getData.expenses
        console.log(incomes);
        console.log(expenses);

        $('.expenses-table').remove();
        $('#expenses-index').append('<table class="expenses-table"></table>')
        $.each(expenses,function(index,val){
          var dateAttr = new Date(val.created_at);
          var month = dateAttr.getMonth()+1;
          var date = dateAttr.getDate();
          month = ('0' + month).slice(-2);
          date = ('0' + date).slice(-2);
          $('.expenses-table').append(
            $("<tr></tr>")
            .append($("<td></td>").text(month + "/" + date ))
            .append($("<td></td>").text(val.expense_category_id))
            .append($("<td></td>").text(val.expense))
            .append($("<td></td>").text(val.details))
          );
        });
        $('.incomes-table').remove();
        $('#incomes-index').append('<table class="incomes-table"></table>')
        $.each(incomes,function(index,val){
          var dateAttr = new Date(val.created_at);
          var month = dateAttr.getMonth()+1;
          var date = dateAttr.getDate();
          month = ('0' + month).slice(-2);
          date = ('0' + date).slice(-2);
          $('.incomes-table').append(
            $("<tr></tr>")
            .append($("<td></td>").text(month + "/" + date ))
            .append($("<td></td>").text(val.income_category_id))
            .append($("<td></td>").text(val.income))
            .append($("<td></td>").text(val.details))
          );
        });


      
      });
  
    });
  }));



// });