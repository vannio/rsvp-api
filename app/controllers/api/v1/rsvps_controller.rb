module Api::V1
  class RsvpsController < BaseController
    before_action :authenticate_request
    before_action :authenticate_admin, only: [:index, :create, :destroy]
    before_action :authenticate_current_user, only: [:show, :update]
    before_action :set_rsvp, only: [:show, :update, :destroy]
    before_action :set_user, if: -> { params[:user_id].present? }
    before_action :set_event, if: -> { params[:event_id].present? }

    # GET /rsvps
    def index
      @rsvps = if @user
        @user.rsvps
      elsif @event
        @event.rsvps
      else
        Rsvp.all
      end

      render json: @rsvps
    end

    # GET /rsvps/1
    def show
      render json: @rsvp
    end

    # POST /rsvps
    def create
      @rsvp = Rsvp.new(rsvp_params)

      if @rsvp.save
        render json: @rsvp, status: :created, location: api_v1_rsvp_url(@rsvp)
      else
        render json: @rsvp.errors, status: :unprocessable_entity
      end
    end

    # PATCH/PUT /rsvps/1
    def update
      if @rsvp.update(rsvp_params)
        render json: @rsvp
      else
        render json: @rsvp.errors, status: :unprocessable_entity
      end
    end

    # DELETE /rsvps/1
    def destroy
      @rsvp.destroy
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_rsvp
        @rsvp = Rsvp.find(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def rsvp_params
        params.require(:rsvp).permit(:user_id, :event_id, :adults, :children, :comments)
      end

      def set_user
        @user = User.find(params[:user_id])
      end

      def set_event
        @event = Event.find(params[:event_id])
      end
  end
end
