class ReviewsController < ApplicationController
  before_action :set_review, only: [:edit, :update, :destroy]
  def create
    @event = Event.find(params[:event_id])
    @review = @event.reviews.new(review_params)
    authorize @review
    @review.user = current_user
    if @review.save
       respond_to do |format|
        format.html { redirect_to event_path(@event) }
        format.js {}
      end
    else
      respond_to do |format|
        format.html { render 'events/show' }
        format.js
      end
    end
  end

  def edit
  end

  def update
    @review.update(review_params)
    redirect_to event_path(@review.event)
  end

  def destroy
    @event = @review.event
    @review.destroy
    redirect_to event_path(@event)
  end

  private

  def review_params
    params.require(:review).permit(:id, :content, :stars, :user_id, :event_id)
  end

  def set_review
    @review = Review.find(params[:id])
    authorize @review
  end
end
