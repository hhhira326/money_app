// $(function() {
  $(document).on('turbolinks:load',(function(){

    $('#searchDate').change(function() {
      var searchDate = $(this).val();
      console.log(searchDate);
      // var pass = location.pathname.split("/");
      // var user_id = pass[2];  

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
          var incomeTotal = getData.incomeTotal
          var expenseTotal = getData.expenseTotal
          var salaryVal = getData.salaryVal
          var sideIncomeVal = getData.sideIncomeVal
          var foodVal = getData.foodVal
          var utilityVal = getData.utilityVal
          var phoneVal = getData.phoneVal
          var transportVal = getData.transportVal
          var beautyVal = getData.beautyVal
          var medicalVal = getData.medicalVal
          var clothingVal = getData.clothingVal
          var dailyVal = getData.dailyVal
          var educationVal = getData.educationVal
          var hobbyVal = getData.hobbyVal
          var housingVal = getData.housingVal
          
          
          
          // グラフの表示/非表示
          $('#expenses-chart').remove();
          $('#incomes-chart').remove();
          $('#expenses-graph').append('<canvas id="expensesAjax-chart" width="400" height="400"></canvas>')
          $('#incomes-graph').append('<canvas id="incomesAjax-chart" width="400" height="400"></canvas>')

          // 支出グラフ
          var ctx = document.getElementById('expensesAjax-chart');
          var myChart = new Chart(ctx, {
          type: 'doughnut',
          data: {
            labels: ['食費', '水道光熱費', '通信費', '交通費', '美容費', '医療費', '被服費', '日用品', '教養費', '趣味・娯楽', '住居費'],
            datasets: [{
              data:[foodVal, utilityVal, phoneVal, transportVal, beautyVal, medicalVal, clothingVal, dailyVal, educationVal, hobbyVal, housingVal], 
              backgroundColor: ['#ffbcbc', '#bcffff', '#ffffbc', '#bcbcff', '#ddbcff', '#bcffdd', '#ffbcff', '#ddffbc', '#bcddff', '#ffddbc', '#ffbcdd'],
            }],
          },
          options: {
            legend: {
              display: false
            }
          }
        });

        // 収入グラフ
        var ctx = document.getElementById('incomesAjax-chart');
        var myChart = new Chart(ctx, {
          type: 'doughnut',
          data: {
            labels: ['給与', '事業・副業'],
            datasets: [{
              data: [salaryVal, sideIncomeVal], 
              backgroundColor: ['#ffadd6', '#ffd6ad'],
            }],
          },
          options: {
            legend: {
              display: false
            }
          }
        });

        // 支出履歴の表示/非表示
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
            .append($("<td></td>").text("¥" + val.expense.toLocaleString()))
            .append($("<td></td>").text(val.details))
          );
        });

        // 収入履歴の表示/非表示
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
            .append($("<td></td>").text("¥" + val.income.toLocaleString()))
            .append($("<td></td>").text(val.details))
          );
        });


      
      });
  
    });
  }));



// });