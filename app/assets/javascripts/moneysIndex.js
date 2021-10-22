// $(function() {
  $(document).on('turbolinks:load',(function(){

    $('#searchDate').change(function() {
      var searchDate = $(this).val();
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

          // グラフで使用するデータ
          var expensesCategory = [ 
            {name:'食費', val: foodVal, color: '#ffbcbc'},
            {name:'水道光熱費', val: utilityVal, color: '#bcffff'},
            {name: '通信費', val: phoneVal, color: '#ffffbc'},
            {name: '交通費', val: transportVal, color: '#bcbcff'},
            {name:'美容費', val: beautyVal, color: '#ddbcff'},
            {name:'医療費', val: medicalVal, color: '#bcffdd'},
            {name: '被服費', val: clothingVal , color: '#ffbcff'},
            {name: '日用品', val: dailyVal, color: '#ddffbc'},
            {name: '教養費', val: educationVal, color: '#bcddff'},
            {name: '趣味・娯楽', val: hobbyVal, color: '#ffddbc'},
            {name: '住居費', val: housingVal, color: '#ffbcdd'},
           ];

           expensesCategory.sort(function(a,b) {
             return b.val - a.val
           });

          let expensesName = [];
          let expensesVal = [];
          let expensesColor =[];
          for (let i = 0; i < expensesCategory.length; i++) {
            expensesName.push(expensesCategory[i].name);
            expensesVal.push(expensesCategory[i].val);
            expensesColor.push(expensesCategory[i].color);
          }

          var incomesCategory = [
            {name: "給与", val: salaryVal, color: '#ffadd6'},
            {name: "事業・副業", val: sideIncomeVal, color: '#ffd6ad'},
          ];

          incomesCategory.sort(function(a,b) {
            return b.val - a.val
          });
          
          let incomesName = [];
          let incomesVal = [];
          let incomesColor = [];
          for (let i = 0; i < incomesCategory.length; i++) {
            incomesName.push(incomesCategory[i].name);
            incomesVal.push(incomesCategory[i].val);
            incomesColor.push(incomesCategory[i].color);
          }
          
          // 収支合計
          $('#moneyTotal h3').html('<span>収入</span> ¥' + incomeTotal.toLocaleString() + ' - <span>支出</span> ¥' + expenseTotal.toLocaleString() + ' = <span>収支</span> ¥' + (incomeTotal - expenseTotal).toLocaleString());

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
            labels: expensesName,
            datasets: [{
              data: expensesVal, 
              backgroundColor: expensesColor,
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
            labels: incomesName,
            datasets: [{
              data: incomesVal, 
              backgroundColor: incomesColor,
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
            .append($("<td></td>").text(category_check(2,val.expense_category_id)))
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
            .append($("<td></td>").text(category_check(1,val.income_category_id)))
            .append($("<td></td>").text("¥" + val.income.toLocaleString()))
            .append($("<td></td>").text(val.details))
          );
        });

        // カテゴリーの名前を表示するためのメソッド
        function category_check(inorout, cate_id) {
          let cate_name = "";
          if (inorout == 1 && cate_id == 1) {
            cate_name = "給与";
          } else if (inorout == 1 && cate_id == 2) {
            cate_name = "事業・副業";
          } else if (inorout == 2 && cate_id == 1) {
            cate_name = "食費";
          } else if (inorout == 2 && cate_id == 2) {
            cate_name = "水道光熱費";
          } else if (inorout == 2 && cate_id == 3) {
            cate_name = "通信費";
          } else if (inorout == 2 && cate_id == 4) {
            cate_name = "交通費";
          } else if (inorout == 2 && cate_id == 5) {
            cate_name = "美容費";
          } else if (inorout == 2 && cate_id == 6) {
            cate_name = "医療費";
          } else if (inorout == 2 && cate_id == 7) {
            cate_name = "被服費";
          } else if (inorout == 2 && cate_id == 8) {
            cate_name = "日用品";
          } else if (inorout == 2 && cate_id == 9) {
            cate_name = "教養費";
          } else if (inorout == 2 && cate_id == 10) {
            ("趣味・娯楽");
          } else if (inorout == 2 && cate_id == 11) {
            ("住居費");
          }
          return cate_name;
        }

      
      });
  
    });
  }));



// });