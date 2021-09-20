class MoneysController < ApplicationController
  def new
    @money= Money.new(money_params)
  end

  def index
  end

  def show
  end

  private

    def money_params
      params.permit(:income, :expense, :income_category_id, :expense_id)
    end
end
