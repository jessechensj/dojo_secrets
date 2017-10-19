class LikesController < ApplicationController
  def create
    Like.create(user_id:params[:user], secret_id:params[:secret])
    redirect_to '/users/' + params[:user].to_s
  end

  def destroy
    like = Like.find_by(user_id:current_user.id, secret_id:params[:id])
    Like.destroy(like)
    redirect_to '/secrets'
  end
end
