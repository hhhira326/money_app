class UsersController < ApplicationController
  before_action :logged_in_user, except: [:new, :create]
  before_action :correct_user, except: [:new, :create, :index]
  before_action :admin_user, only: :index

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
      flash.now[:danger] = '登録に失敗しました'
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
      flash.now[:danger] = '登録に失敗しました'
      render 'new'
    end
  end

  def index
    @users = User.where(resign: false).page(params[:page]).per(5)
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
      flash.now[:danger] = '更新に失敗しました'
      render 'edit'
    end
  end
  
  def unsubscribe
    @user = User.find_by(id: params[:id])
  end

  def resign
    @user = User.find(session[:user_id])
    @user.update(resign: true)
    reset_session
    flash[:success] = '退会完了'
    redirect_to top_path
  end

  private
    def admin_user
      redirect_to top_path unless current_user.admin?
    end  
    def user_params
      params.require(:user).permit(:name, :email, :age, :job_id, :sex, :family, :prefecture_id, :rent, :income, :password, :password_confirmation, :avatar, :resign)
    end
    def correct_user
      @user = User.find(params[:id])
      redirect_to top_path unless current_user?(@user)
    end

end
