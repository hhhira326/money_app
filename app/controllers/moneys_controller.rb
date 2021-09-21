class MoneysController < ApplicationController
  def new
    # @user = User.find(params[:user_id])
    @money= Money.new
  end

  def create
    @money = Money.new(money_params)
    if @money.save
      flash[:success] = '登録しました'
    else
      p "===================="
      p params
      p @user.errors.full_messages
      p "===================="
      render 'new'
    end
  end

  def index
    @moneys = Money.all
  end

  def show

  end

  private

    def money_params
      params.require(:money).permit(:income, :expense, :income_category_id, :expense_id)
    end
end
