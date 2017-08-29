module Api::V1
  class RsvpsController < BaseController
    before_action :authenticate_request
    before_action :set_rsvp, only: [:show, :update, :destroy]

    # GET /rsvps
    def index
      @users = User.all.map do |user|
        {
          user: user.slice(:id, :first_name, :last_name),
          events: user.rsvps.map do |rsvp|
            rsvp.event.slice(:id, :title).merge({
              rsvp: rsvp.responded? ? rsvp.slice(:id, :adults, :children, :comments) : nil
            })
          end
        }
      end

      render json: @users
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
  end
end
