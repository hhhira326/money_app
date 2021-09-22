class MoneysController < ApplicationController
  def new
    # @user = User.find(params[:user_id])
    @money = current_user.money.new
  end

  def create
    @money = current_user.money.new(money_params)
    if @money.save
      flash[:success] = '登録しました'
      render 'new'
    else
      flash[:alert] = '登録に失敗しました'
      render 'new'
    end
  end

  def index
    @user = User.find_by(id: params[:id])
    @money = @user.money.all
  end

  def show

  end

  private

    def money_params
      params.require(:money).permit(:income, :expense, :income_category_id, :expense_category_id, :details, :created_at)
    end
end
