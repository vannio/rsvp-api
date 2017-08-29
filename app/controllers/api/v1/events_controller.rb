module Api::V1
  class EventsController < BaseController
    before_action :authenticate_request, only: [:create, :update, :destroy]
    before_action :set_event, only: [:show, :update, :destroy]

    # GET /events
    def index
      @events = Event.all

      render json: @events
    end

    # GET /events/1
    def show
      # TODO: Use serializer
      render json: @event.slice(:id, :title, :date, :time).merge({
        venue: @event.venue
          .slice(:id, :name, :url, :description)
          .merge({
            address: @event.venue.try(:address).try(:slice, :id, :street, :city, :postcode, :country, :lat, :lng)
          })
        })
    end

    # POST /events
    def create
      @event = Event.new(event_params)

      if @event.save
        render json: @event, status: :created, location: api_v1_event_url(@event)
      else
        render json: @event.errors, status: :unprocessable_entity
      end
    end

    # PATCH/PUT /events/1
    def update
      if @event.update(event_params)
        render json: @event
      else
        render json: @event.errors, status: :unprocessable_entity
      end
    end

    # DELETE /events/1
    def destroy
      @event.destroy
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_event
        @event = Event.find(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def event_params
        params.require(:event).permit(:title, :date, :time, :venue_id)
      end
  end
end
