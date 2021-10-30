$(function () {
  $('#expense select').change(function() {
    let expenseId = $(this).val();
    let pass = location.pathname.split("/");
    let userId = pass[2];  

    $.ajax({
      type: 'GET',
      url: '/users/:user_id/expenseBar',
      data: {
        expenseId: expenseId,
        userId: userId
      },
      dataType: 'json'
    })
    .done(function(data) {
      let labels = data.labels;
      let searchCateVal = data.searchCateVal;
      let cateName;
      let cateColor;
      if (expenseId == 1) {
        cateName = "食費";
        cateColor = "#ffbcbc";
      } else if (expenseId == 2) {
        cateName = "水道光熱費";
        cateColor = "#bcffff";
      } else if (expenseId == 3) {
        cateName = "通信費";
        cateColor = "#ffffbc";
      } else if (expenseId == 4) {
        cateName = "交通費";
        cateColor = "#bcbcff";
      } else if (expenseId == 5) {
        cateName = "美容費";
        cateColor = "#ddbcff";
      } else if (expenseId == 6) {
        cateName = "医療費";
        cateColor = "#bcffdd";
      } else if (expenseId == 7) {
        cateName = "被服費";
        cateColor = "#ffbcff";
      } else if (expenseId == 8) {
        cateName = "日用品";
        cateColor = "#ddffbc";
      } else if (expenseId == 9) {
        cateName = "教養費";
        cateColor = "#bcddff";
      } else if (expenseId == 10) {
        cateName = "趣味・娯楽";
        cateColor = "#ffddbc";
      } else if (expenseId == 11) {
        cateName = "住居費";
        cateColor = "#ffbcdd";
      } else if (expenseId == 12) {
        cateName = "未分類";
        cateColor = "#c993ff";
      }

      if (expenseId == 0) {
        $('#expensesBar').show();
        $('#expensesBarAjax').hide();
      } else {
        $('#expensesBar').hide();
        $('#expensesChart').append('<canvas id="expensesBarAjax"></canvas>');
      }
      var ctx = document.getElementById("expensesBarAjax").getContext("2d");
      var myBar = new Chart(ctx, {
        type: 'bar',                          
        data: {
          labels: labels,
          datasets: [
            {         
              label: cateName,
              data: searchCateVal,
              backgroundColor: cateColor,
            }
          ],
        },
        options: {
          responsive: true,
          legend: {
            display: false,
          },
          tooltips: {
            callbacks: {
              label: function(tooltipItem, data) {
                return tooltipItem.yLabel.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',') +'円';
              }
            }
          },              
          scales: {
            xAxes: [{ 
              barPercentage: 0.5,  
              stacked: true,
            }],
            yAxes: [{
              stacked: true,
              ticks: {
                callback: function(label,index,labels) {
                  return label.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',');
                }
              }              
            }],
          },
        }
      });
    });
  });

  $('#income select').change(function() {
    let incomeId = $(this).val();
    let pass = location.pathname.split("/");
    let userId = pass[2]; 

    $.ajax({
      type: 'GET',
      url: '/users/:user_id/incomeBar',
      data: {
        incomeId: incomeId,
        userId: userId
      },
      dataType: 'json'
    })
    .done(function(data) {
      let labels = data.labels;
      let searchCateVal = data.searchCateVal;
      let cateName;
      let cateColor;
      if (incomeId == 1) {
        cateName = "給与";
        cateColor = "#ffadd6";
      } else if (incomeId == 2) {
        cateName = "事業・副業";
        cateColor = "#ffd6ad";
      } else if (incomeId == 3) {
        cateName = "未分類";
        cateColor = "#c993ff";
      }
      
      if (incomeId == 0) {
        $('#incomesBar').show();
        $('#incomesBarAjax').hide();
      } else {
        $('#incomesBar').hide();
        $('#incomesChart').append('<canvas id="incomesBarAjax"></canvas>');
      }
      var ctx = document.getElementById("incomesBarAjax").getContext("2d");
      var myBar = new Chart(ctx, {
        type: 'bar',                          
        data: {
          labels: labels,
          datasets: [
            {         
              label: cateName,
              data: searchCateVal,
              backgroundColor: cateColor,
            }
          ],
        },
        options: {
          responsive: true,
          legend: {
            display: false,
          },
          tooltips: {
            callbacks: {
              label: function(tooltipItem, data) {
                return tooltipItem.yLabel.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',') +'円';
              }
            }
          },              
          scales: {
            xAxes: [{ 
              barPercentage: 0.5,  
              stacked: true,
            }],
            yAxes: [{
              stacked: true,
              ticks: {
                callback: function(label,index,labels) {
                  return label.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',');
                }
              }              
            }],
          },
        }
      });
    });
  });
  

});