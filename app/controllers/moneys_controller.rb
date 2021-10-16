class MoneysController < ApplicationController
  def new
    # user = User.find(params[:user_id])
    @money = current_user.money.new
  end

  def create
    @money = current_user.money.new(money_params)
    if @money.save
      p "===================="
      p params
      p "===================="
      flash[:success] = '登録しました'
      redirect_to new_user_money_path(current_user.id)
    else
      flash[:alert] = '登録に失敗しました'
      render 'new'
    end
  end

  def index
    p "===================="
    p params
    p "===================="
    @user = User.find_by(id: params[:user_id])
    today = Time.now.strftime("%Y-%m")
    @moneys = @user.money.where("created_at LIKE ?" , "%#{today}%")
    @incomes = @moneys.where("income > ?", 0)
    @expenses = @moneys.where("expense > ?", 0)
    # 給料合計
    @salary = @incomes.where(income_category_id: 1) 
    @salaryVal = 0
    @salary.each do |i|
      @salaryVal += i.income
    end
    gon.salaryVal = @salaryVal
    # 副収入合計
    @sideIncome = @incomes.where(income_category_id: 2) 
    @sideIncomeVal = 0
    @sideIncome.each do |i|
      @sideIncomeVal += i.income
    end
    gon.sideIncomeVal = @sideIncomeVal
    # 食費
    @food = @expenses.where(expense_category_id: 1) 
    @foodVal = 0
    @food.each do |e|
      @foodVal += e.expense
    end
    gon.foodVal = @foodVal
    # 水道光熱費
    @utility = @expenses.where(expense_category_id: 2) 
    @utilityVal = 0
    @utility.each do |e|
      @utilityVal += e.expense
    end
    gon.utilityVal = @utilityVal
    # 通信費
    @phone = @expenses.where(expense_category_id: 3) 
    @phoneVal = 0
    @phone.each do |e|
      @phoneVal += e.expense
    end
    gon.phoneVal = @phoneVal
    # 交通費
    @transport = @expenses.where(expense_category_id: 4) 
    @transportVal = 0
    @transport.each do |e|
      @transportVal += e.expense
    end
    gon.transportVal = @transportVal
    # 美容費
    @beauty = @expenses.where(expense_category_id: 5) 
    @beautyVal = 0
    @beauty.each do |e|
      @beautyVal += e.expense
    end
    gon.beautyVal = @beautyVal
    # 医療費
    @medical = @expenses.where(expense_category_id: 6) 
    @medicalVal = 0
    @medical.each do |e|
      @medicalVal += e.expense
    end
    gon.medicalVal = @medicalVal
    # 被服費
    @clothing = @expenses.where(expense_category_id: 7) 
    @clothingVal = 0
    @clothing.each do |e|
      @clothingVal += e.expense
    end
    gon.clothingVal = @clothingVal
    # 日用品
    @daily = @expenses.where(expense_category_id: 8) 
    @dailyVal = 0
    @daily.each do |e|
      @dailyVal += e.expense
    end
    gon.dailyVal = @dailyVal
    # 教養費
    @education = @expenses.where(expense_category_id: 9) 
    @educationVal = 0
    @education.each do |e|
      @educationVal += e.expense
    end
    gon.educationVal = @educationVal
    # 趣味・娯楽
    @hobby = @expenses.where(expense_category_id: 10) 
    @hobbyVal = 0
    @hobby.each do |e|
      @hobbyVal += e.expense
    end
    gon.hobbyVal = @hobbyVal
    # 住居費
    @housing = @expenses.where(expense_category_id: 11) 
    @housingVal = 0
    @housing.each do |e|
      @housingVal += e.expense
    end
    gon.housingVal = @housingVal
    @incomeTotal = @salaryVal + @sideIncomeVal
    @expenseTotal = @foodVal + @utilityVal + @phoneVal + @transportVal + @beautyVal + @medicalVal + @clothingVal + @dailyVal + @educationVal + @hobbyVal + @housingVal
    

  end

  def search
    p "===================="
    p params
    p "===================="
    moneys = Money.where("created_at LIKE ?" , "%#{params[:searchDate]}%")
    incomes = moneys.where("income > ?", 0)
    expenses = moneys.where("expense > ?", 0)

    # 給料合計
    salary = incomes.where(income_category_id: 1) 
    salaryVal = 0
    salary.each do |i|
      salaryVal += i.income
    end
    
    # 副収入合計
    sideIncome = incomes.where(income_category_id: 2) 
    sideIncomeVal = 0
    sideIncome.each do |i|
      sideIncomeVal += i.income
    end
    
    # 食費
    food = expenses.where(expense_category_id: 1) 
    foodVal = 0
    food.each do |e|
      foodVal += e.expense
    end
    
    # 水道光熱費
    utility = expenses.where(expense_category_id: 2) 
    utilityVal = 0
    utility.each do |e|
      utilityVal += e.expense
    end
    
    # 通信費
    phone = expenses.where(expense_category_id: 3) 
    phoneVal = 0
    phone.each do |e|
      phoneVal += e.expense
    end
    
    # 交通費
    transport = expenses.where(expense_category_id: 4) 
    transportVal = 0
    transport.each do |e|
      transportVal += e.expense
    end
    
    # 美容費
    beauty = expenses.where(expense_category_id: 5) 
    beautyVal = 0
    beauty.each do |e|
      beautyVal += e.expense
    end
    
    # 医療費
    medical = expenses.where(expense_category_id: 6) 
    medicalVal = 0
    medical.each do |e|
      medicalVal += e.expense
    end
    
    # 被服費
    clothing = expenses.where(expense_category_id: 7) 
    clothingVal = 0
    clothing.each do |e|
      clothingVal += e.expense
    end
    
    # 日用品
    daily = expenses.where(expense_category_id: 8) 
    dailyVal = 0
    daily.each do |e|
      dailyVal += e.expense
    end
    
    # 教養費
    education = expenses.where(expense_category_id: 9) 
    educationVal = 0
    education.each do |e|
      educationVal += e.expense
    end
    
    # 趣味・娯楽
    hobby = expenses.where(expense_category_id: 10) 
    hobbyVal = 0
    hobby.each do |e|
      hobbyVal += e.expense
    end
    
    # 住居費
    housing = expenses.where(expense_category_id: 11) 
    housingVal = 0
    housing.each do |e|
      housingVal += e.expense
    end
    
    incomeTotal = salaryVal + sideIncomeVal
    expenseTotal = foodVal + utilityVal + phoneVal + transportVal + beautyVal + medicalVal + clothingVal + dailyVal + educationVal + hobbyVal + housingVal

    incomes = incomes.as_json(only: ['income','income_category_id', 'details', 'created_at', 'user_id'])
    expenses = expenses.as_json(only: ['expense' ,'expense_category_id', 'details', 'created_at', 'user_id'])
    
    
    respond_to do |format|
      format.json { render json: {incomes: incomes, expenses: expenses, incomeTotal: incomeTotal, expenseTotal: expenseTotal, salaryVal: salaryVal, sideIncomeVal: sideIncomeVal, foodVal: foodVal, utilityVal: utilityVal, phoneVal: phoneVal, transportVal: transportVal, beautyVal: beautyVal, medicalVal: medicalVal, clothingVal: clothingVal, dailyVal: dailyVal, educationVal: educationVal, hobbyVal: hobbyVal, housingVal: housingVal} }
    end

  end

  def show

  end

  private

    def money_params
      params.require(:money).permit(:income, :expense, :income_category_id, :expense_category_id, :details, :created_at, :user_id)
    end
end
