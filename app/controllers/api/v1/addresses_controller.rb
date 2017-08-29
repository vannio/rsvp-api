module Api::V1
  class AddressesController < BaseController
    before_action :authenticate_request
    before_action :authenticate_admin, only: [:create, :destroy]
    before_action :authenticate_current_user, only: [:show, :update]
    before_action :set_address, only: [:show, :update, :destroy]
    before_action :set_venue, if: -> { params[:venue_id].present? }
    before_action :set_user, if: -> { params[:user_id].present? }

    # GET /addresses
    def index
      @addresses = if @venue
        [*@venue.address]
      elsif @user
        [*@user.address]
      else
        Address.all
      end

      render json: @addresses
    end

    # GET /addresses/1
    def show
      render json: @address
    end

    # POST /addresses
    def create
      @address = Address.new(address_params)

      if @address.save
        render json: @address, status: :created, location: api_v1_address_url(@address)
      else
        render json: @address.errors, status: :unprocessable_entity
      end
    end

    # PATCH/PUT /addresses/1
    def update
      if @address.update(address_params)
        render json: @address
      else
        render json: @address.errors, status: :unprocessable_entity
      end
    end

    # DELETE /addresses/1
    def destroy
      @address.destroy
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_address
        @address = Address.find(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def address_params
        params.require(:address).permit(:street, :city, :postcode, :country, :lat, :lng)
      end

      def set_venue
        @venue = Venue.find(params[:venue_id])
      end

      def set_user
        @user = User.find(params[:user_id])
      end
  end
end
