class MoneysController < ApplicationController
  def new
    # @user = User.find(params[:user_id])
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
    gon.user = @user
    @moneys = @user.money.where("created_at LIKE ?" , "%#{params[:search_date]}%")
    @incomes = @moneys.where("income > ?", 0)
    @expenses = @moneys.where("expense > ?", 0)
  end

  def search
    p "===================="
    p params
    p "===================="
    @user = User.find_by(id: params[:user_id])
    @moneys = @user.money.where("created_at LIKE ?" , "%#{params[:search_date]}%")
    @incomes = @moneys.where("income > ?", 0)
    @expenses = @moneys.where("expense > ?", 0)
    render 'index'

  end

  def show

  end

  private

    def money_params
      params.require(:money).permit(:income, :expense, :income_category_id, :expense_category_id, :details, :created_at, :user_id)
    end
end
