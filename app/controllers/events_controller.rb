class EventsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]
  before_action :set_event, only: [:show, :edit, :update, :destroy]

  def index
    @results = policy_scope(Event)
    if params[:search]
      @results = @results.search(params[:search])
      @filter = { type: "Recherche", value: params[:search] }
    end
    if params[:genre]
      @results = @results.where('music_genre ILIKE ?', "%#{params[:genre]}%")
      @filter = { type: "Genre musical", value: params[:genre] }
    end

    if params[:lat] && params[:lng]
      @results = @results.where(location_id: Location.near([params[:lat], params[:lng]], 50, units: :km).map(&:id))
      @filter = { type: "Concerts près de chez moi"}
    end

    @pagy, @events = pagy(@results, items: 12)
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
