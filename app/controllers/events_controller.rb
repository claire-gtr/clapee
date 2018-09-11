class EventsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]
  def index
    @events = policy_scope(Event)
  end

  def show
    @event = Event.find(params[:id])
    authorize @event
    @review = Review.new
    @reviews = @event.reviews
  end

  def edit
    @event = Event.find(params[:id])
    authorize @event
  end

  def update
    @event = Event.find(params[:id])
    authorize @event
    @event.update(event_params)
    redirect_to event_path(@event)
  end

  def destroy
    @event = Event.find(params[:id])
    authorize @event
    @event.destroy
    redirect_to root_path
  end

  private

  def event_params
    params.require(:event).permit(:id, :title, :description)
  end
end
