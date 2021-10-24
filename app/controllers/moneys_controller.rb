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
    user = User.find_by(id: params[:userId])
    moneys = user.money.where("created_at LIKE ?" , "%#{params[:searchDate]}%")
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
  
  def graph
    @user = User.find_by(id: params[:user_id])

    gon.labels = []
    gon.salaryVal = []
    gon.sideIncomeVal = []
    gon.foodVal = []
    gon.utilityVal = []
    gon.phoneVal = []
    gon.transportVal = []
    gon.beautyVal = []
    gon.medicalVal = []
    gon.clothingVal = []
    gon.dailyVal = []
    gon.educationVal = []
    gon.hobbyVal = []
    gon.housingVal = []
  
    @money = @user.money.all.order(created_at: :asc)
    start = @money.first.created_at.strftime("%Y-%m-%d")
    startDay = @money.first.created_at.strftime("%d").to_i

    last = Time.now.strftime("%Y-%m-%d")
    lastDay = Time.now.strftime("%d").to_i

    (Date.parse(start)..Date.parse(last)).select{ |d| d.day == startDay }.each do |date|
      searchDate = date.strftime("%Y-%m")
      labelDate = date.strftime("%Y/%m")
      gon.labels.push(labelDate)
      gon.salaryVal.push(@money.where(income_category_id: 1).where("created_at LIKE ?", "#{searchDate}%").sum(:income))
      gon.sideIncomeVal.push(@money.where(income_category_id: 2).where("created_at LIKE ?", "#{searchDate}%").sum(:income))
      gon.foodVal.push(@money.where(expense_category_id: 1).where("created_at LIKE ?", "#{searchDate}%").sum(:expense))
      gon.utilityVal.push(@money.where(expense_category_id: 2).where("created_at LIKE ?", "#{searchDate}%").sum(:expense))
      gon.phoneVal.push(@money.where(expense_category_id: 3).where("created_at LIKE ?", "#{searchDate}%").sum(:expense))
      gon.transportVal.push(@money.where(expense_category_id: 4).where("created_at LIKE ?", "#{searchDate}%").sum(:expense))
      gon.beautyVal.push(@money.where(expense_category_id: 5).where("created_at LIKE ?", "#{searchDate}%").sum(:expense))
      gon.medicalVal.push(@money.where(expense_category_id: 6).where("created_at LIKE ?", "#{searchDate}%").sum(:expense))
      gon.clothingVal.push(@money.where(expense_category_id: 7).where("created_at LIKE ?", "#{searchDate}%").sum(:expense))
      gon.dailyVal.push(@money.where(expense_category_id: 8).where("created_at LIKE ?", "#{searchDate}%").sum(:expense))
      gon.educationVal.push(@money.where(expense_category_id: 9).where("created_at LIKE ?", "#{searchDate}%").sum(:expense))
      gon.hobbyVal.push(@money.where(expense_category_id: 10).where("created_at LIKE ?", "#{searchDate}%").sum(:expense))
      gon.housingVal.push(@money.where(expense_category_id: 11).where("created_at LIKE ?", "#{searchDate}%").sum(:expense))
    end

    if startDay > lastDay
      lastMonth = Time.now.strftime("%Y-%m")
      labelLast = Time.now.strftime("%Y/%m")
      gon.labels.push(labelLast)      
      gon.salaryVal.push(@money.where(income_category_id: 1).where("created_at LIKE ?", "#{lastMonth}%").sum(:income))
      gon.sideIncomeVal.push(@money.where(income_category_id: 2).where("created_at LIKE ?", "#{lastMonth}%").sum(:income))
      gon.foodVal.push(@money.where(expense_category_id: 1).where("created_at LIKE ?", "#{lastMonth}%").sum(:expense))
      gon.utilityVal.push(@money.where(expense_category_id: 2).where("created_at LIKE ?", "#{lastMonth}%").sum(:expense))
      gon.phoneVal.push(@money.where(expense_category_id: 3).where("created_at LIKE ?", "#{lastMonth}%").sum(:expense))
      gon.transportVal.push(@money.where(expense_category_id: 4).where("created_at LIKE ?", "#{lastMonth}%").sum(:expense))
      gon.beautyVal.push(@money.where(expense_category_id: 5).where("created_at LIKE ?", "#{lastMonth}%").sum(:expense))
      gon.medicalVal.push(@money.where(expense_category_id: 6).where("created_at LIKE ?", "#{lastMonth}%").sum(:expense))
      gon.clothingVal.push(@money.where(expense_category_id: 7).where("created_at LIKE ?", "#{lastMonth}%").sum(:expense))
      gon.dailyVal.push(@money.where(expense_category_id: 8).where("created_at LIKE ?", "#{lastMonth}%").sum(:expense))
      gon.educationVal.push(@money.where(expense_category_id: 9).where("created_at LIKE ?", "#{lastMonth}%").sum(:expense))
      gon.hobbyVal.push(@money.where(expense_category_id: 10).where("created_at LIKE ?", "#{lastMonth}%").sum(:expense))
      gon.housingVal.push(@money.where(expense_category_id: 11).where("created_at LIKE ?", "#{lastMonth}%").sum(:expense))

    end
  end

  def expenseBar
    @user = User.find_by(id: params[:userId])

    labels = []
    searchCateVal = []
  
    @money = @user.money.all.order(created_at: :asc)
    searchCate = @money.where(expense_category_id: params[:expenseId])
    start = @money.first.created_at.strftime("%Y-%m-%d")
    startDay = @money.first.created_at.strftime("%d").to_i

    last = Time.now.strftime("%Y-%m-%d")
    lastDay = Time.now.strftime("%d").to_i

    (Date.parse(start)..Date.parse(last)).select{ |d| d.day == startDay }.each do |date|
      searchDate = date.strftime("%Y-%m")
      labelDate = date.strftime("%Y/%m")
      labels.push(labelDate)
      searchCateVal.push(searchCate.where("created_at LIKE ?", "#{searchDate}%").sum(:expense))
    end

    if startDay > lastDay
      lastMonth = Time.now.strftime("%Y-%m")
      labelLast = Time.now.strftime("%Y/%m")
      labels.push(labelLast)      
      searchCateVal.push(searchCate.where("created_at LIKE ?", "#{lastMonth}%").sum(:expense))
    end

    respond_to do |format|
      format.json { render json:{ labels: labels, searchCateVal: searchCateVal } }
    end
  end

  def incomeBar
    @user = User.find_by(id: params[:userId])

    labels = []
    searchCateVal = []
  
    @money = @user.money.all.order(created_at: :asc)
    searchCate = @money.where(income_category_id: params[:incomeId])
    start = @money.first.created_at.strftime("%Y-%m-%d")
    startDay = @money.first.created_at.strftime("%d").to_i

    last = Time.now.strftime("%Y-%m-%d")
    lastDay = Time.now.strftime("%d").to_i

    (Date.parse(start)..Date.parse(last)).select{ |d| d.day == startDay }.each do |date|
      searchDate = date.strftime("%Y-%m")
      labelDate = date.strftime("%Y/%m")
      labels.push(labelDate)
      searchCateVal.push(searchCate.where("created_at LIKE ?", "#{searchDate}%").sum(:income))
    end

    if startDay > lastDay
      lastMonth = Time.now.strftime("%Y-%m")
      labelLast = Time.now.strftime("%Y/%m")
      labels.push(labelLast)      
      searchCateVal.push(searchCate.where("created_at LIKE ?", "#{lastMonth}%").sum(:income))
    end

    respond_to do |format|
      format.json { render json:{ labels: labels, searchCateVal: searchCateVal } }
    end
  end

  def show
  end

  private

    def money_params
      params.require(:money).permit(:income, :expense, :income_category_id, :expense_category_id, :details, :created_at, :user_id)
    end
end
