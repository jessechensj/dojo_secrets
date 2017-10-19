class SessionsController < ApplicationController
  skip_before_action :require_login, only: [:new, :create]

  def new
  end

  def create
      user = User.find_by(email:params[:Email])
      if user.try(:authenticate, params[:Password])
      # if authenticate true
          session[:user_id] = user.id
          # save user id to session
          redirect_to '/users/' + user.id.to_s
          # redirect to users profile page
      # if authenticate false
      else
          # add an error message -> flash[:errors] = ["Invalid"]
          flash[:errors] = ['Invalid Combination']
          # redirect to login page
          redirect_to '/sessions/new'
      end
  end
  
  def destroy
      # Log User out
      session[:user_id] = nil
      # set session[:user_id] to null
      redirect_to '/sessions/new'
      # redirect to login page
  end
end