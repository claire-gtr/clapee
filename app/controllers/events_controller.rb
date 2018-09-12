class EventsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]
  before_action :set_event, only: [:show, :edit, :update, :destroy]

  def index
    @events = policy_scope(Event)
  end

  def show
    authorize @event
    @review = Review.new
    @reviews = @event.reviews
  end

  def edit
    authorize @event
  end

  def update
    authorize @event
    @event.update(event_params)
    redirect_to event_path(@event)
  end

  def destroy
    authorize @event
    @event.destroy
    redirect_to root_path
  end

  private
  def set_event
    @event = Event.find(params[:id])
  end
  def event_params
    params.require(:event).permit(:id, :title, :description, :location_name, :location_zipcode, :location_address, :location_id, :location_town, :artist_name)
  end
end
