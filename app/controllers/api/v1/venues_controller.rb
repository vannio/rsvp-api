module Api::V1
  class VenuesController < BaseController
    before_action :authenticate_request, only: [:create, :update, :destroy]
    before_action :authenticate_admin, only: [:create, :update, :destroy]
    before_action :set_venue, only: [:show, :update, :destroy]
    before_action :set_event, if: -> { params[:event_id].present? }

    # GET /venues
    def index
      @venues = @event ? [*@event.venue] : Venue.all

      render json: @venues
    end

    # GET /venues/1
    def show
      render json: @venue
    end

    # POST /venues
    def create
      @venue = Venue.new(venue_params)

      if @venue.save
        render json: @venue, status: :created, location: api_v1_venue_url(@venue)
      else
        render json: @venue.errors, status: :unprocessable_entity
      end
    end

    # PATCH/PUT /venues/1
    def update
      if @venue.update(venue_params)
        render json: @venue
      else
        render json: @venue.errors, status: :unprocessable_entity
      end
    end

    # DELETE /venues/1
    def destroy
      @venue.destroy
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_venue
        @venue = Venue.find(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def venue_params
        params.require(:venue).permit(:name, :url, :description, :address_id)
      end

      def set_event
        @event = Event.find(params[:event_id])
      end
  end
end
