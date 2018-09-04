class EventsController < ApplicationController
  skip_before_action :authenticate_user!
  def index
    @events = Event.all
  end

  def show
    @event = Event.find(params[:id])
  end

  def edit
    @event = Event.find(params[:id])
  end

  def update
    @event = Event.find(params[:id])
    @event.update(event_params)
    redirect_to event_path(@event)
  end

  def destroy
    @event = Event.find(params[:id])
    @event.destroy
    redirect_to root_path
  end

  private

  def event_params
    params.require(:event).permit(:id, :title, :description)
  end
end
