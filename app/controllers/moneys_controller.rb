class MoneysController < ApplicationController
  before_action :logged_in_user, except: [:search, :update, :expenseBar, :incomeBar]
  before_action :correct_user, except: [:search, :update, :expenseBar, :incomeBar]

  def new
    @money = current_user.money.new
  end

  def create
    @money = current_user.money.new(money_params)
    if @money.save
      flash[:success] = '登録完了'
      redirect_to new_user_money_path(current_user.id)
    else
      render 'new'
      flash.now[:danger] = '登録できませんでした'
    end
  end

  def index
    @user = User.find_by(id: params[:user_id])
    thisMonth = Time.now.strftime("%Y-%m")
    @moneys = @user.money.where("cast(created_at as TEXT) LIKE ?" , "%#{thisMonth}%")
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
    # 未分類合計
    @unCateIncome = @incomes.where(income_category_id: 3) 
    @unCateIncomeVal = 0
    @unCateIncome.each do |i|
      @unCateIncomeVal += i.income
    end
    gon.unCateIncomeVal = @unCateIncomeVal
  
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
    # 未分類
    @unCateExpense = @expenses.where(expense_category_id: 12) 
    @unCateExpenseVal = 0
    @unCateExpense.each do |e|
      @unCateExpenseVal += e.expense
    end
    gon.unCateExpenseVal = @unCateExpenseVal

    @incomeTotal = @salaryVal + @sideIncomeVal + @unCateIncomeVal
    @expenseTotal = @foodVal + @utilityVal + @phoneVal + @transportVal + @beautyVal + @medicalVal + @clothingVal + @dailyVal + @educationVal + @hobbyVal + @housingVal + @unCateExpenseVal
    

  end

  def search
    user = User.find_by(id: params[:userId])
    moneys = user.money.where("cast(created_at as TEXT) LIKE ?" , "%#{params[:searchDate]}%")
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

    # 未分類
    unCateIncome = incomes.where(income_category_id: 3) 
    unCateIncomeVal = 0
    unCateIncome.each do |i|
      unCateIncomeVal += i.income
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

    # 未分類
    unCateExpense = expenses.where(expense_category_id: 12) 
    unCateExpenseVal = 0
    unCateExpense.each do |e|
      unCateExpenseVal += e.expense
    end
    
    incomeTotal = salaryVal + sideIncomeVal + unCateIncomeVal
    expenseTotal = foodVal + utilityVal + phoneVal + transportVal + beautyVal + medicalVal + clothingVal + dailyVal + educationVal + hobbyVal + housingVal + unCateExpenseVal

    incomes = incomes.as_json(only: ['id', 'income','income_category_id', 'details', 'created_at', 'user_id'])
    expenses = expenses.as_json(only: ['id', 'expense' ,'expense_category_id', 'details', 'created_at', 'user_id'])
    
    
    respond_to do |format|
      format.json { render json: {incomes: incomes, expenses: expenses, incomeTotal: incomeTotal, expenseTotal: expenseTotal, salaryVal: salaryVal, sideIncomeVal: sideIncomeVal, unCateIncomeVal: unCateIncomeVal, foodVal: foodVal, utilityVal: utilityVal, phoneVal: phoneVal, transportVal: transportVal, beautyVal: beautyVal, medicalVal: medicalVal, clothingVal: clothingVal, dailyVal: dailyVal, educationVal: educationVal, hobbyVal: hobbyVal, housingVal: housingVal, unCateExpenseVal: unCateExpenseVal} }
    end

  end
  
  def graph
    @user = User.find_by(id: params[:user_id])

    gon.labels = []
    gon.salaryVal = []
    gon.sideIncomeVal = []
    gon.unCateIncomeVal = []
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
    gon.unCateExpenseVal = []
  
    @money = @user.money.all.order(created_at: :asc)
    if @money.present?
      start = @money.first.created_at.strftime("%Y-%m-%d")
      startDay = @money.first.created_at.strftime("%d").to_i
      last = Time.now.strftime("%Y-%m-%d")
      lastDay = Time.now.strftime("%d").to_i
  
      (Date.parse(start)..Date.parse(last)).select{ |d| d.day == startDay }.each do |date|
        searchDate = date.strftime("%Y-%m")
        labelDate = date.strftime("%Y/%m")
        gon.labels.push(labelDate)
        gon.salaryVal.push(@money.where(income_category_id: 1).where("cast(created_at as TEXT) LIKE ?", "#{searchDate}%").sum(:income))
        gon.sideIncomeVal.push(@money.where(income_category_id: 2).where("cast(created_at as TEXT) LIKE ?", "#{searchDate}%").sum(:income))
        gon.unCateIncomeVal.push(@money.where(income_category_id: 3).where("cast(created_at as TEXT) LIKE ?", "#{searchDate}%").sum(:income))
        gon.foodVal.push(@money.where(expense_category_id: 1).where("cast(created_at as TEXT) LIKE ?", "#{searchDate}%").sum(:expense))
        gon.utilityVal.push(@money.where(expense_category_id: 2).where("cast(created_at as TEXT) LIKE ?", "#{searchDate}%").sum(:expense))
        gon.phoneVal.push(@money.where(expense_category_id: 3).where("cast(created_at as TEXT) LIKE ?", "#{searchDate}%").sum(:expense))
        gon.transportVal.push(@money.where(expense_category_id: 4).where("cast(created_at as TEXT) LIKE ?", "#{searchDate}%").sum(:expense))
        gon.beautyVal.push(@money.where(expense_category_id: 5).where("cast(created_at as TEXT) LIKE ?", "#{searchDate}%").sum(:expense))
        gon.medicalVal.push(@money.where(expense_category_id: 6).where("cast(created_at as TEXT) LIKE ?", "#{searchDate}%").sum(:expense))
        gon.clothingVal.push(@money.where(expense_category_id: 7).where("cast(created_at as TEXT) LIKE ?", "#{searchDate}%").sum(:expense))
        gon.dailyVal.push(@money.where(expense_category_id: 8).where("cast(created_at as TEXT) LIKE ?", "#{searchDate}%").sum(:expense))
        gon.educationVal.push(@money.where(expense_category_id: 9).where("cast(created_at as TEXT) LIKE ?", "#{searchDate}%").sum(:expense))
        gon.hobbyVal.push(@money.where(expense_category_id: 10).where("cast(created_at as TEXT) LIKE ?", "#{searchDate}%").sum(:expense))
        gon.housingVal.push(@money.where(expense_category_id: 11).where("cast(created_at as TEXT) LIKE ?", "#{searchDate}%").sum(:expense))
        gon.unCateExpenseVal.push(@money.where(expense_category_id: 12).where("cast(created_at as TEXT) LIKE ?", "#{searchDate}%").sum(:expense))
      end
  
      if startDay > lastDay
        lastMonth = Time.now.strftime("%Y-%m")
        labelLast = Time.now.strftime("%Y/%m")
        gon.labels.push(labelLast)      
        gon.salaryVal.push(@money.where(income_category_id: 1).where("cast(created_at as TEXT) LIKE ?", "#{lastMonth}%").sum(:income))
        gon.sideIncomeVal.push(@money.where(income_category_id: 2).where("cast(created_at as TEXT) LIKE ?", "#{lastMonth}%").sum(:income))
        gon.unCateIncomeVal.push(@money.where(income_category_id: 3).where("cast(created_at as TEXT) LIKE ?", "#{lastMonth}%").sum(:income))
        gon.foodVal.push(@money.where(expense_category_id: 1).where("cast(created_at as TEXT) LIKE ?", "#{lastMonth}%").sum(:expense))
        gon.utilityVal.push(@money.where(expense_category_id: 2).where("cast(created_at as TEXT) LIKE ?", "#{lastMonth}%").sum(:expense))
        gon.phoneVal.push(@money.where(expense_category_id: 3).where("cast(created_at as TEXT) LIKE ?", "#{lastMonth}%").sum(:expense))
        gon.transportVal.push(@money.where(expense_category_id: 4).where("cast(created_at as TEXT) LIKE ?", "#{lastMonth}%").sum(:expense))
        gon.beautyVal.push(@money.where(expense_category_id: 5).where("cast(created_at as TEXT) LIKE ?", "#{lastMonth}%").sum(:expense))
        gon.medicalVal.push(@money.where(expense_category_id: 6).where("cast(created_at as TEXT) LIKE ?", "#{lastMonth}%").sum(:expense))
        gon.clothingVal.push(@money.where(expense_category_id: 7).where("cast(created_at as TEXT) LIKE ?", "#{lastMonth}%").sum(:expense))
        gon.dailyVal.push(@money.where(expense_category_id: 8).where("cast(created_at as TEXT) LIKE ?", "#{lastMonth}%").sum(:expense))
        gon.educationVal.push(@money.where(expense_category_id: 9).where("cast(created_at as TEXT) LIKE ?", "#{lastMonth}%").sum(:expense))
        gon.hobbyVal.push(@money.where(expense_category_id: 10).where("cast(created_at as TEXT) LIKE ?", "#{lastMonth}%").sum(:expense))
        gon.housingVal.push(@money.where(expense_category_id: 11).where("cast(created_at as TEXT) LIKE ?", "#{lastMonth}%").sum(:expense))
        gon.unCateExpenseVal.push(@money.where(expense_category_id: 12).where("cast(created_at as TEXT) LIKE ?", "#{lastMonth}%").sum(:expense))
      end
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
      searchCateVal.push(searchCate.where("cast(created_at as TEXT) LIKE ?", "#{searchDate}%").sum(:expense))
    end

    if startDay > lastDay
      lastMonth = Time.now.strftime("%Y-%m")
      labelLast = Time.now.strftime("%Y/%m")
      labels.push(labelLast)      
      searchCateVal.push(searchCate.where("cast(created_at as TEXT) LIKE ?", "#{lastMonth}%").sum(:expense))
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
      searchCateVal.push(searchCate.where("cast(created_at as TEXT) LIKE ?", "#{searchDate}%").sum(:income))
    end

    if startDay > lastDay
      lastMonth = Time.now.strftime("%Y-%m")
      labelLast = Time.now.strftime("%Y/%m")
      labels.push(labelLast)      
      searchCateVal.push(searchCate.where("cast(created_at as TEXT) LIKE ?", "#{lastMonth}%").sum(:income))
    end

    respond_to do |format|
      format.json { render json:{ labels: labels, searchCateVal: searchCateVal } }
    end
  end

  def average
  end

  def show
  end

  def update
    @user = User.find_by(id: current_user.id)
    @money = @user.money.find_by(id: money_params[:id])
    if params[:update] 
      if @money.update(money_params)
        flash[:success] = "更新完了"
        redirect_to user_moneys_path(@user)
      else
        render 'index'
        flash.now[:danger] = "更新できませんでした"
      end
    elsif params[:destroy]
      if @money.delete
        flash[:success] = "削除完了"
        redirect_to user_moneys_path(@user)
      else
        render 'index'
        flash.now[:danger] = "削除できませんでした"
      end
    end
  end

  private

    def money_params
      params.require(:money).permit(:id, :income, :expense, :income_category_id, :expense_category_id, :details, :created_at, :user_id)
    end
    def correct_user
      @user = User.find_by(id: params[:user_id])
      redirect_to top_path unless current_user?(@user)
    end

end
