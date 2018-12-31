class EventsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]
  before_action :set_event, only: [:show, :edit, :update, :destroy]

  def index
    @events = policy_scope(Event)
    @results = @events.future

    if params[:search]
      @results = @events.search(params[:search])
      @filter = { type: "Recherche", value: params[:search] }
    end

    if params[:genre]
      @results = @events.where('music_genre ILIKE ?', "%#{params[:genre]}%")
      @filter = { type: "Genre musical", value: params[:genre] }
    end

    # if params[:best_rated]
    #   @results = @events.select("events.id, event.reviews.stars.count as average_rating, count(reviews.id) as number_of_reviews")
    #                     .group("events.id")
    #                     .order("average_rating DESC, number_of_reviews DESC")
    #   @filter = { type: "Les mieux notés" }
    # end

    if params[:lat] && params[:lng]
      @results = @events.where(location_id: Location.near([params[:lat], params[:lng]], 200, units: :km).map(&:id))
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
