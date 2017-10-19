class SecretsController < ApplicationController
  before_action :same_user, only: [:destroy]

  def index
    @secrets = Secret.all
  end

  def create
    secret = Secret.new(content:params[:Content], user:User.find(params[:user_id]))
    secret.save
    flash[:errors] = secret.errors.full_messages
    redirect_to '/users/' + params[:user_id].to_s
  end

  def destroy
    user = Secret.find(params[:id]).user
    Secret.destroy(params[:id])
    redirect_to '/users/' + user.id.to_s
  end

  private 
    def same_user
      if Secret.find(params[:id]).user.id.to_s != session[:user_id].to_s
        redirect_to '/users/' + session[:user_id].to_s
      end
    end
end
