class EventsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]
  before_action :set_event, only: [:show, :edit, :update, :destroy]

  def index
    @pagy, @events = pagy(policy_scope(Event), items: 10)
  end

  def show
    @review = Review.new
    @reviews = @event.reviews
  end

  def edit
  end

  def update
    @event.update(event_params)
    redirect_to event_path(@event)
  end

  def destroy
    @event.destroy
    redirect_to root_path
  end

  private
  def set_event
    @event = Event.find(params[:id])
    authorize @event
  end
  def event_params
    params.require(:event).permit(:id, :title, :description, :location_name, :location_zipcode, :location_address, :location_id, :location_town, :artist_name)
  end
end
