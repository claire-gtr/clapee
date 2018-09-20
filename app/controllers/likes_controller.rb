class LikesController < ApplicationController

  # POST /reviews/:review_id/likes/
  def create
    @review = Review.find(params[:review_id])
    @like = @review.likes.new
    @like.user = current_user
    authorize @like
    @like.save
    respond_to do |format|
      format.html { redirect_to event_path(@review.event) }
      format.js # render views/likes/create.js.erb
    end
  end

  def destroy
    @like = Like.find(params[:id])
    @review = @like.review
    authorize @like
    @like.destroy
    respond_to do |format|
      format.html { redirect_to event_path(@review.event) }
      format.js # render views/likes/destroy.js.erb
    end
  end
end
