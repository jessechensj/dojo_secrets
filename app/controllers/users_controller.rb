class UsersController < ApplicationController
  skip_before_action :require_login, only: [:new, :create]

  before_action :same_user, except: [:new, :create]

  def new
  end

  def create
    user = User.new(name:params[:Name], email:params[:Email], password:params[:Password])
    if user.valid?
      user.save
      redirect_to '/sessions/new'
    else
      flash[:errors] = user.errors.full_messages
      redirect_to '/users/new'
    end
  end

  def show
    @user = User.find(params[:id])
    @secrets = Secret.all
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    update = User.update(params[:id], name:params[:Name], email:params[:Email])
    if update.valid?
      redirect_to '/users/' + params[:id].to_s
    else
      flash[:errors] = update.errors.full_messages
      redirect_to '/users/' + params[:id].to_s + '/edit'
    end
  end

  def destroy
    User.destroy(params[:id])
    reset_session
    redirect_to '/users/new'
  end

  private

  def same_user
    if params[:id] != session[:user_id].to_s
      redirect_to '/users/' + session[:user_id].to_s
    end
  end
end
