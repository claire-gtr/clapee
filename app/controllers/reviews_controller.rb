class ReviewsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]
  def new
    @event = Event.find(params[:event_id])
    @review = Review.new
  end

  def create
    @event = Event.find(params[:event_id])
    @review = @event.reviews.new(review_params)
    @review.user = current_user
    if @review.save
      redirect_to event_path(@event)
    else
      render 'events/show'
    end
  end

  def edit
    @event = Event.find(params[:event_id])
    @review = Review.find(params[:id])
  end

  def update
    @event = Event.find(params[:event_id])
    @review = Review.find(params[:id])
    @review.update(review_params)
    redirect_to event_path(@event)
  end

  def destroy
    @review = Review.find(params[:id])
    @event = @review.event
    @review.destroy
    redirect_to event_path(@event)
  end

  private

  def review_params
    params.require(:review).permit(:id, :content, :stars, :user_id, :event_id)
  end
end
