class LikesController < ApplicationController

  def new
    @review = Review.find(params[:review_id])
    @like = Like.new
  end

  def create
    @review = Review.find(params[:review_id])
    @like = @review.likes.new(like_params)
    @like.user = current_user
    if @like.save
      redirect_to review_path(@review)
    else
      render 'events/show'
    end
  end

  def destroy
    @like = Like.find(params[:id])
    @review = @like.review
    @like.destroy
    render 'events/show'
  end

  def like_params
    params.require(:like).permit(:id, :review_id, :user_id)
  end

end
