class UsersController < ApplicationController
  before_action :logged_in_user, only[:edit, :update, :destroy]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = '会員登録完了'
      redirect_to @user
    else
      render 'new'
    end
  end

  def index
    @user = User.all
  end
  

  def show
    # @user_img = params.require(:user).permit(:name, :age, :avatar)
    @user = User.find_by(id: params[:id])
  end

  def edit
    @user = User.find_by(id: params[:id])
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :age, :job, :sex, :family, :prefucture_id, :city, :other_address, :img, :rent, :income, :password_figes)
    end
end
