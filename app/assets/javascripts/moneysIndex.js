// $(function() {
  $(document).on('turbolinks:load',(function(){

    // 履歴詳細モーダル
    let trId;
    let trDate;
    let trCate;
    let trMoney;
    let trDetail;
    $('tr[data-href]').addClass('clickable')
    .click(function(e) {
      trDate = $(this).find('td').eq(0).text().replace(/[/]/g, "-");
      trCate = $(this).find('td').eq(1).text();
      trMoney = $(this).find('td').eq(2).text().replace(/[^0-9]/g, '');
      trDetail = $(this).find('td').eq(3).text();
      trId = $(this).find('input[name="id"]').val();
      if(!$(e.target).is('a')){
        window.location = $(e.target).closest('tr').data('href');
      }
      let trCateId;
      $('.trMoney').val(trMoney);
      if ($(this).parents('table').hasClass('incomes-table')) {
        trCateId = incomeCate_check(trCate);
      } else if ($(this).parents('table').hasClass('expenses-table')) {
        trCateId = expenseCate_check(trCate)
      }
      $('.trId').val(trId);
      $('.trCate').val(trCateId);
      $('.trDate').val(trDate);
      $('.trDetail').val(trDetail);
    });

    function expenseCate_check(cateName) {
      let cateId;
      if (cateName == "食費") {
        cateId = 1;
      } else if (cateName == "水道光熱費") {
        cateId = 2;
      } else if (cateName == "通信費") {
        cateId = 3;
      } else if (cateName == "交通費") {
        cateId = 4;
      } else if (cateName == "美容費") {
        cateId = 5;
      } else if (cateName == "医療費") {
        cateId = 6;
      } else if (cateName == "被服費") {
        cateId = 7;
      } else if (cateName == "日用品") {
        cateId = 8;
      } else if (cateName == "教養費") {
        cateId = 9;
      } else if (cateName == "趣味・娯楽") {
        cateId = 10;
      } else if (cateName == "住居費") {
        cateId = 11;
      } else if (cateName == "未分類") {
        cateId = 12;
      }
      return cateId;
    }
    function incomeCate_check(cateName) {
      let cateId;
      if (cateName == "給与") {
        cateId = 1;
      } else if (cateName == "事業・副業") {
        cateId = 2;
      } else if (cateName == "未分類") {
        cateId = 3;
      }
      return cateId;
    }


    $('#searchDate').change(function() {
      var searchDate = $(this).val();
      var pass = location.pathname.split("/");
      var userId = pass[2];  

      $.ajax({
        type: 'GET',
        url: '/users/:user_id/search',
        data: {
          searchDate: searchDate,
          userId: userId
        },
          dataType: 'json'
        })
        .done(function(getData) {
          var incomes = getData.incomes
          var expenses = getData.expenses
          var incomeTotal = getData.incomeTotal
          var expenseTotal = getData.expenseTotal
          var salaryVal = getData.salaryVal
          var sideIncomeVal = getData.sideIncomeVal
          var unCateIncomeVal = getData.unCateIncomeVal
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
          var unCateExpenseVal = getData.unCateExpenseVal


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
            {name: '未分類', val: unCateExpenseVal, color: '#c993ff'}
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
            {name: '未分類', val: unCateIncomeVal, color: '#c99fff'}
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
            },
            tooltips: {
              callbacks: {
                label: function(tooltipItem,data) {
                  return data.labels[tooltipItem.index]
                    + " : "
                    + data.datasets[0].data[tooltipItem.index].toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',') 
                    +' 円';
                }
              }
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
            },
            tooltips: {
              callbacks: {
                label: function(tooltipItem,data) {
                  return data.labels[tooltipItem.index]
                    + " : "
                    + data.datasets[0].data[tooltipItem.index].toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',') 
                    +' 円';
                }
              }
            }             
          }
        });
        $('.nodata').hide();
        // if (incomes.length == 0) {
        //   $('#income').html('<h5 class="text-center mt-5 nodata">登録されているデータがありません。</h2>');
        // } 
        // if (expenses.length == 0) {
        //   $('#expense').html('<h5 class="text-center mt-5 nodata">登録されているデータがありません。</h2>');
        // }

        // 支出履歴の表示/非表示
        $('.expenses-table').remove();
        $('#expenses-index').append('<table class="expenses-table"></table>')
        $.each(expenses,function(index,val){
          var dateAttr = new Date(val.created_at);
          var year = dateAttr.getFullYear();
          var month = dateAttr.getMonth()+1;
          var date = dateAttr.getDate();
          month = ('0' + month).slice(-2);
          date = ('0' + date).slice(-2);
          $('.expenses-table').append(
            $('<tr data-href="#"  data-toggle="modal" data-target="#indexModal"></tr>')
            .append($(`<input type="hidden" name="id" value="${val.id}">`))
            .append($("<td></td>").text(year + "/" + month + "/" + date ))
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
          var year = dateAttr.getFullYear();
          var month = dateAttr.getMonth()+1;
          var date = dateAttr.getDate();
          month = ('0' + month).slice(-2);
          date = ('0' + date).slice(-2);
          $('.incomes-table').append(
            $('<tr data-href="#"  data-toggle="modal" data-target="#incomeModal"></tr>')
            .append($(`<input type="hidden" name="id" value="${val.id}">`))
            .append($("<td></td>").text(year + "/" + month + "/" + date ))
            .append($("<td></td>").text(category_check(1,val.income_category_id)))
            .append($("<td></td>").text("¥" + val.income.toLocaleString()))
            .append($("<td></td>").text(val.details))
          );
        });

        // 履歴詳細モーダル
        let trId;
        let trDate;
        let trCate;
        let trMoney;
        let trDetail;
        $('tr[data-href]').addClass('clickable')
        .click(function(e) {
          trDate = $(this).find('td').eq(0).text().replace(/[/]/g, "-");
          trCate = $(this).find('td').eq(1).text();
          trMoney = $(this).find('td').eq(2).text().replace(/[^0-9]/g, '');
          trDetail = $(this).find('td').eq(3).text();
          trId = $(this).find('input[name="id"]').val();
          if(!$(e.target).is('a')){
            window.location = $(e.target).closest('tr').data('href');
          }
          let trCateId;
          $('.trMoney').val(trMoney);
          if ($(this).parents('table').hasClass('incomes-table')) {
            trCateId = incomeCate_check(trCate);
          } else if ($(this).parents('table').hasClass('expenses-table')) {
            trCateId = expenseCate_check(trCate)
          }
          $('.trId').val(trId);
          $('.trCate').val(trCateId);
          $('.trDate').val(trDate);
          $('.trDetail').val(trDetail);
        });

        function expenseCate_check(cateName) {
          let cateId;
          if (cateName == "食費") {
            cateId = 1;
          } else if (cateName == "水道光熱費") {
            cateId = 2;
          } else if (cateName == "通信費") {
            cateId = 3;
          } else if (cateName == "交通費") {
            cateId = 4;
          } else if (cateName == "美容費") {
            cateId = 5;
          } else if (cateName == "医療費") {
            cateId = 6;
          } else if (cateName == "被服費") {
            cateId = 7;
          } else if (cateName == "日用品") {
            cateId = 8;
          } else if (cateName == "教養費") {
            cateId = 9;
          } else if (cateName == "趣味・娯楽") {
            cateId = 10;
          } else if (cateName == "住居費") {
            cateId = 11;
          } else if (cateName == "未分類") {
            cateId = 12;
          }
          return cateId;
        }
        function incomeCate_check(cateName) {
          let cateId;
          if (cateName == "給与") {
            cateId = 1;
          } else if (cateName == "事業・副業") {
            cateId = 2;
          } else if (cateName == "未分類") {
            cateId = 3;
          }
          return cateId;
        }

        // カテゴリーの名前を表示するためのメソッド
        function category_check(inorout, cate_id) {
          let cate_name = "";
          if (inorout == 1 && cate_id == 1) {
            cate_name = "給与";
          } else if (inorout == 1 && cate_id == 2) {
            cate_name = "事業・副業";
          } else if (inorout == 1 && cate_id == 3) {
            cate_name = "未分類";
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
            cate_name = ("趣味・娯楽");
          } else if (inorout == 2 && cate_id == 11) {
            cate_name = ("住居費");
          } else if (inorout == 2 && cate_id == 12) {
            cate_name = ("未分類");
          }
          return cate_name;
        }
      });
  
    });
  }));



// });