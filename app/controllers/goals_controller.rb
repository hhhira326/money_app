class GoalsController < ApplicationController
  def new
    @user = User.find_by(id: params[:user_id])
    @goal = @user.goals.new
    @latest = @user.goals.order(created_at: :desc).find_by("goalSavings > ?", 0)
    @latestDay = @latest.goalDeadline.strftime("%Y/%m/%d")
    @goalTable = @user.goals.order(deadline: :asc).where("savings > ?", 0)
    @hideTable = @goalTable.where(check: true)
    from = Date.today
    to = from + 6.day
    @nearDeadline = @goalTable.where(deadline: from..to)
    gon.goalTable = @goalTable
    gon.latest = @latest
    gon.latestDay = @latestDay
    gon.nearDeadline = @nearDeadline
  end

  def create
    @goal = current_user.goals.new(goals_params)
    if @goal.save
      p "===================="
      p params
      p "===================="
      flash[:success] = '登録しました'
      redirect_to goal_path(current_user.id)
    else
      flash[:alert] = '登録に失敗しました'
      render 'new'
    end
  end

  def check
    @goal = current_user.goals.find_by(id: params[:checkId])
    @goal.update(check: params[:checkVal])
    p "===================="
    p params
    p "===================="
    respond_to do |format|
      format.json {render json: @goal}
    end

  end

  private
    def goals_params
      params.require(:goals).permit(:goalSavings, :goalDeadline, :category, :way, :savings, :deadline, :check, :user_id, :created_at)
    end
end
