class ReviewsController < ApplicationController
  def create
    @event = Event.find(params[:event_id])
    @review = @event.reviews.new(review_params)
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
