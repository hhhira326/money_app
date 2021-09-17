class UsersController < ApplicationController
  # before_action :logged_in_user, only: [:edit, :update, :destroy]

  def new
    @user = User.new
  end

  def new_detail
    @user = User.find_by(id: params[:id])
  end

  def datail_create
    @user = User.find_by(id: params[:id])
    if @user.update(user_params)
      flash[:success] = "登録完了"
    else
      render 'new_detail'
    end
  end
  
  def create
    @user = User.new(user_params)
    @user.avatar = "icon.png"
    @user.name = "noname"
    if @user.save
      log_in @user
      redirect_to detail_path(@user)
      flash[:success] = '会員登録完了'
    else
      p "===================="
      p params
      p @user.errors.full_messages
      p "===================="
      render 'new'
    end
  end

  def index
    @user = User.all
  end
  

  def show
    @user = User.find_by(id: params[:id])
  end

  def edit
    @user = User.find_by(id: params[:id])
  end

  def update
    @user = User.find_by(id: params[:id])
    if @user.update(user_params)
      flash[:success] = "更新完了"
      redirect_to user_path(@user)
    else
      render 'edit'
    end
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :age, :job, :sex, :family, :prefecture_id, :city, :address, :img, :rent, :income, :password, :password_confirmation, :avatar)
    end
end
